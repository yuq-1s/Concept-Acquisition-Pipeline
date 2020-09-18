import math
import re
import tqdm
import sys
import fire
import config
import json
import utils

def load_file(subtitle_filename, concept_filename):
    def preprocess(document):
        document = document.lower()
        return document
    if subtitle_filename:
        with open(subtitle_filename) as f:
            subtitles = list(map(preprocess, f))
    else:
        print("Reading from stdin...")
        subtitles = list(map(preprocess, sys.stdin))
    concepts = []
    with open(concept_filename) as f:
        for line in f:
            line = line.strip().strip('"')
            try:
                concepts.append(json.loads(line)['name'])
            except (json.decoder.JSONDecodeError, TypeError):
                concepts.append(line)
    return subtitles, concepts

def my_filter(string):
    string = re.sub(r'[ -~]+', lambda x: f' {x.group(0)} ', string)
    return re.sub(r'\s+', r' ', string)

def tf_idf_dict(documents, keywords):
    tf_dict = [{} for _ in documents]
    for i, doc in enumerate(documents):
        for kw in keywords:
            # prevent 'd算法' matches 'floyd算法'
            cnt = (' ' + my_filter(doc) + ' ').count(my_filter(kw))
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
    for tf in tqdm.tqdm(tf_dict):
        scores = {k: formula(k, freq) for k, freq in tf.items()}
        ret.append([x[0] for x in sorted(scores.items(), key=lambda x: -x[1]) if x[1] > threshold])
    return ret

def main(subtitle_filename: str = config.context_folder_path + '/' + config.file_name,
        concept_filename: str = config.Evaluation.gold_filename,
        max_subtitle_len: int = 1500,
        threshold: float = 2.):
    subtitles, concepts = load_file(subtitle_filename, concept_filename)
    results = rank_keywords(subtitles, concepts, threshold)
    for subtitle, result in zip(subtitles, results):
        if len(subtitle) < max_subtitle_len:
            print(json.dumps({'subtitle': subtitle, 'concept': result}, ensure_ascii=False))

if __name__ == '__main__':
    fire.Fire(main)
