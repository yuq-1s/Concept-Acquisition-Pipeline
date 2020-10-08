import logging
import csv
import itertools
import argparse
import random
import json
import numpy as np
import copy

def load_json(filename, extract_fn):
    with open(filename) as f:
        for line in f:
            yield extract_fn(json.loads(line))

def precision(gold, predicted, k):
    return len(gold.intersection(predicted[:k])) / k

# Assumes gold (train set and test set) should be ranked higher
def ap_at_k(gold, predicted, n):
    predicted = predicted[:n]
    return sum(precision(gold, predicted, k) * (thing in gold) for k, thing in enumerate(predicted) if k > 0) / min(len(gold), n-1)

def load_evaluated(filename, gold, seeds, relevance_field_name=None):
    if relevance_field_name:
        evals = list(load_json(filename, lambda x: {'name': x['name'], 'score': x[relevance_field_name]}))
        predicted = [thing['name'] for thing in sorted(evals, key=lambda x: -x['score'])]
    else:
        predicted = [thing['name'] for thing in load_json(filename, lambda x: {'name': x['name']})]
    if seeds:
        predicted = [p for p in predicted if p not in seeds]
    return predicted

def evaluate(predicted, gold, k, ndcg=False, display=False):
    random_predicted = copy.copy(predicted)
    random.shuffle(random_predicted)
    if len(gold.intersection(predicted)) < 30:
        logging.warning("Not enough gold included in the list to be evaluated. This evaluation may not be accurate.")
    results = {}
    results[f'mAP@{k}'] = ap_at_k(gold, predicted, k)
    results[f'p@{k}'] = precision(gold, predicted, k)
    results[f'random_mAP@{k}'] = ap_at_k(gold, random_predicted, k)
    results[f'random_p@{k}'] = precision(gold, random_predicted, k)
    if ndcg:
        from sklearn.metrics import ndcg_score
        scores = np.array([thing['score'] for thing in evals])
        targets = np.array([thing['name'] in gold for thing in evals])
        results[f'nDCG@{k}'] = ndcg_score([targets[:k]], [scores[:k]])
        random.shuffle(scores)
        results[f'random_nDCG@{k}'] = ndcg_score([targets[:k]], [scores[:k]])
    if display:
        print(predicted[:k])
    return results

def dump_to_csv(results, filename):
    new_results = {x[0]: {} for x in results}
    for (evaluated_filename, k), result in results.items():
        new_results[evaluated_filename][f'mAP@{k}'] = result[f'mAP@{k}']
        new_results[evaluated_filename][f'p@{k}'] = result[f'p@{k}']
    with open(filename, 'w') as csv_file:
        writer = csv.writer(csv_file)
        keys = list(map(lambda x: f'{x[0]}@{x[1]}', itertools.product(['mAP', 'p'], config.topks)))
        writer.writerow(['algorithm'] + keys)
        for ef, result in new_results.items():
            writer.writerow([config.file2algo[ef]] + [f'{result[k]:.3f}' for k in keys])

def merge_results(results):
    get_key = lambda k: k[0].split('/')[-1].split('_nf')[0]
    ret = {get_key(key): {} for key in results}
    for key, value in results.items():
        ret[get_key(key)].update(
            {k: v for k, v in value.items() if not k.startswith('random')}
        )
    return ret

def load_gold_and_seeds(gold_filename, seed_filename):
    gold = set(load_json(gold_filename, lambda x: x['name']))
    if seed_filename:
        with open(seed_filename) as f:
            seeds = set([line.strip() for line in f])
        gold = set(gold) - seeds
    else:
        seeds = set()
    return gold, seeds


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Evaluate ranking of concepts with a list of relavent concepts (e.g. evaluate concept expansion with seed concepts). '
            'This file calculates mAP@k, precision@k (and nDCG@k if provided with scores).')
    parser.add_argument('-c', '--config', action='store_true', help='use config file for evaluating multiple algorithms, in Python, containing gold_filename, evaluated_filenames and ks')
    parser.add_argument('-g', '--gold-filename',
            help='Gold file: lines of json format. (concept order in this file does not matter). '
            'This file contains relevant concepts that should appear in the evaluated ranking. '
            'Optimally it should be all concepts in the relevant field annotated by human. '
            'However, parts of concepts is also OK to evaluate. '
            'For example, seeds used in concept expansion. '
            'Each line is a dict with key `name`, whose value is the name of the concept. '
            'Example line: `{"name": "binary tree"}`.')
    parser.add_argument('-e', '--evaluated-filename',
            help='Evaluated ranking file: lines of json format (concept order in this file matters). '
            'Each line is a dict with key `name`, whose value is the name of the concept. '
            'If `score` argument is provided, json of each line is expeceted to contain another key `score`, whose value is the a positive score of the concept. '
            'Example line: `{"name": "binary tree", "score": 0.523148}`.')
    parser.add_argument('-k', '--topk', help='The `k` of mAP@k. Top k of ranking to be evaluated.')
    parser.add_argument('-r', '--relevance', help='key name for score in file to be evaluated')
    parser.add_argument('-n', '--ndcg', action='store_true',
            help='Enables nDCG computation. json of each line of `evaluated_filename` is expeceted to contain key `score`, whose value is the score of the concept.')
    parser.add_argument('-s', '--seed-filename', help='Only evaluate words appearing in `gold_filename` and not in `seed_filename`.')
    parser.add_argument('-d', '--display', action='store_true', help='Display top k words.')

    args = parser.parse_args()
    assert args.config or (args.gold_filename and args.evaluated_filename and args.topk), \
            "Please specify either config file, or (gold_filename, evaluated_filename, topk), but not both"
    if args.config:
        import config
        config = config.Evaluation
        gold_filename = config.gold_filename
        seed_filename = config.seed_filename
    else:
        gold_filename = args.gold_filename
        seed_filename = args.seed_filename
    gold, seeds = load_gold_and_seeds(gold_filename, seed_filename)
    if args.config:
        import config
        config = config.Evaluation
        results = {}
        for (evaluated_filename, field_name), k in itertools.product(
                zip(config.evaluated_filenames, config.relevance_field_names),
                config.topks):
            predicted = load_evaluated(evaluated_filename, gold, seeds, field_name)
            result = evaluate(predicted, gold, k, ndcg=args.ndcg, display=args.display)
            results[(evaluated_filename, k)] = result
        results = merge_results(results)
        if config.dump_csv:
            dump_to_csv(results, config.dump_csv)
        print(json.dumps(results))
    else:
        predicted = load_evaluated(args.evaluated_filename, gold, seeds,
            args.relevance)
        result = evaluate(predicted, gold, int(args.topk), ndcg=args.ndcg, display=args.display)
        print(result)
