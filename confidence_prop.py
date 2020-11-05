import config
import argparse
import os
import confidence_propagation.preprocess as preprocess
import confidence_propagation.tf_idf as tf_idf
def main():
    parser = argparse.ArgumentParser(description='process some parameters, the whole parameters are in config.py')
    parser.add_argument('--input_text', '-it', default=config.input_text,type=str, help='the text file for concept extraction task')
    parser.add_argument('--input_seed', '-is',default=config.input_seed, type=str, help='the seed file for concept extraction | expansion task')
    parser.add_argument('--language', '-l', default='zh', type=str, choices=['zh', 'en'], help='zh | en', required=True)
    parser.add_argument('--snippet_source', '-ss', default='baidu', type=str, choices=['baidu', 'google', 'bing'], help='baidu | google | bing')
    parser.add_argument('--times', '-t', default=10, type=int, help='iteration times for graph propagation algorithm')
    parser.add_argument('--max_num', '-m', default=-1, type=int, help='maximun number for outgoing edges of each node, "-1" means unlimited')
    parser.add_argument('--decay', '-d', default=0.8, type=float, help='decay for graph propagation algorithm')
    parser.add_argument('--threshold', '-th', default=0.7, type=float, help='similarity threshold for graph edges')
    parser.add_argument('--no_seed', '-ns', action='store_true', help='every candidate in text will be a seed')
    parser.add_argument('--noun_filter', '-nf', action='store_true', help='remove non noun candidates')
    parser.add_argument('--result', '-r', default=config.result_path, type=str, help='result file path')
    parser.add_argument('--algorithm', '-a', type=str, default='graph_prop', choices=['graph_prop', 'average_distance', 'tf_idf', 'pagerank'], help='graph_prop | average_distance | tf_idf | pagerank')
    args = parser.parse_args()
    if not args.no_seed and not args.input_seed:
        raise Exception('seed config error')
    config.input_text = args.input_text
    config.input_seed = args.input_seed
    config.language = args.language
    config.snippet_source = args.snippet_source
    config.times = args.times
    config.max_num = args.max_num
    config.decay = args.decay
    config.threshold = args.threshold
    config.no_seed = True if args.no_seed else False
    config.noun_filter = True if args.noun_filter else False
    preprocess.get_candidates()
    assert args.algorithm == 'tf_idf', f"Unsupported algorithm {args.algorithm}"
    tf_idf.get_result()

if __name__ == '__main__':
    main()
