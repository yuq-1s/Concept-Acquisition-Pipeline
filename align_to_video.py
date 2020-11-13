import math
import jsonlines
import re
import tqdm
import sys
import fire
import config
import json
import utils

def load_exercise(filename):
    cleanr = re.compile('<.*?>|&([a-z0-9]+|#[0-9]{1,6}|#x[0-9a-f]{1,6});')
    clr = lambda x: re.sub(cleanr, '', x)
    with jsonlines.open('results/exercise_dsa.jsonl') as reader:
        for obj in reader:
            if 'Options' not in obj:
                continue
            item = {'body': clr(obj['Body']),
                'options': {
                    o['key']: clr(o['value']) for o in obj['Options']
                },
                'answer': obj['Answer']}
            yield item['body'] + '。' +  '。'.join(item['options'].values())

def load_concepts(concept_filename):
    concepts = []
    with open(concept_filename) as f:
        for line in f:
            line = line.strip().strip('"')
            try:
                concepts.append(json.loads(line)['name'].strip())
            except (json.decoder.JSONDecodeError, TypeError):
                concepts.append(line.strip())
    return concepts

def load_video_subtitle(subtitle_filename):
    def preprocess(document):
        document = document.lower()
        return document
    if subtitle_filename:
        with open(subtitle_filename) as f:
            f = list(f)
            try:
                lines = [json.loads(line) for line in f]
                subtitles = [preprocess(l['text']) for l in lines]
                titles = [preprocess(l['section_title']) for l in lines]
            except (json.decoder.JSONDecodeError, TypeError):
                subtitles = list(map(preprocess, f))
                titles = []
    else:
        print("Reading from stdin...")
        subtitles = list(map(preprocess, sys.stdin))
    return titles, subtitles

def my_filter(string):
    string = re.sub(r'[ -~]+', lambda x: f' {x.group(0)} ', string)
    return re.sub(r'\s+', r' ', string)

def my_count(doc, kw):
    return (' ' + my_filter(doc) + ' ').count(my_filter(kw))

def tf_idf_dict(documents, keywords):
    tf_dict = [{} for _ in documents]
    print("Matching string...")
    for i, doc in enumerate(tqdm.tqdm(documents)):
        for kw in keywords:
            # prevent 'd算法' matches 'floyd算法'
            cnt = my_count(doc, kw)
            if cnt > 0:
                tf_dict[i][kw] = cnt
    idf_dict = {}
    for kw in keywords:
        occurance = sum(1 for i in range(len(documents)) if kw in tf_dict[i])
        if occurance > 0:
            idf_dict[kw] = len(documents) / occurance
    return tf_dict, idf_dict

def rank_keywords(documents, keywords, threshold):
    tf_dict, idf_dict = tf_idf_dict(documents, keywords)
    ret = []
    def formula(kw, freq):
        # return math.log(freq + 1) * math.log(idf_dict[kw] + 1)
        return 1 * math.log(idf_dict[kw] + 1)
    print("Calculating score...")
    for tf in tqdm.tqdm(tf_dict):
        scores = {k: formula(k, freq) for k, freq in tf.items()}
        ret.append([x[0] for x in sorted(scores.items(), key=lambda x: -x[1]) if x[1] > threshold])
    return ret

def is_noun(flag):
    return re.match(
        r'^(@(([av]?n[rstz]?)|l|a|v))*(@(([av]?n[rstz]?)|l))$', flag) is not None

def get_candidates(line):
    res = set()
    seg = [(t.word, t.flag) for t in pseg.cut(line)]
    n = len(seg)
    for i in range(n):
        phrase, flag = seg[i][0], '@'+seg[i][1]
        for j in range(i+1, min(n+1, i+7)):
            if phrase not in res and is_noun(flag):
                res.add(phrase)
            if j < n:
                phrase += seg[j][0]
                flag += '@'+seg[j][1]
    return res

def main(save_filename: str,
        subtitle_filename: str = config.context_folder_path + '/' + config.file_name,
        concept_filename: str = config.Evaluation.gold_filename,
        max_subtitle_len: int = 1500,
        threshold: float = 2.,
        include_first_n_occurance: int = 2,
        include_title: bool = True,
        is_exercise: bool = False):
    if is_exercise:
        assert include_title == False
        subtitles = list(load_exercise(subtitle_filename))
    else:
        titles, subtitles = load_video_subtitle(subtitle_filename)
    concepts = load_concepts(concept_filename)
    print("Load subtitle and concept finished")
    results = rank_keywords(subtitles, concepts, threshold)

    if include_title:
        assert titles, "No section titles found"
        assert len(titles) == len(results)
        for concept in concepts:
            for title, result in zip(titles, results):
                if concept in title:
                    if concept not in result:
                        result.append(concept)

    if include_first_n_occurance > 0:
        assert len(subtitles) == len(results)
        foo = {c: 0 for c in concepts}
        print("Adding first occurance of concepts...")
        for i, (subtitle, result) in enumerate(zip(tqdm.tqdm(subtitles), results)):
            for concept in concepts:
                if foo[concept] < include_first_n_occurance \
                        and my_count(subtitle, concept) > 0:
                            foo[concept] += 1
                            if concept not in result:
                                result.append(concept)

    with open(save_filename, 'w') as f:
        for subtitle, result in zip(subtitles, results):
            if len(subtitle) < max_subtitle_len:
                f.write(json.dumps({'text': subtitle, 'concept': list(result)}, ensure_ascii=False) + '\n')

if __name__ == '__main__':
    fire.Fire(main)
