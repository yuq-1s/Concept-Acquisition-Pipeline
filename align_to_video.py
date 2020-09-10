import math
import config
import json
import utils

def load_file(subtitle_filename, concept_filename):
    def preprocess(document):
        document = document.lower()
        return document
    with open(subtitle_filename) as f:
        subtitles = list(map(preprocess, f))
    concepts = []
    with open(concept_filename) as f:
        for line in f:
            concepts.append(json.loads(line)['name'])
    return subtitles, concepts

def tf_idf_dict(documents, keywords):
    tf_dict = [{} for _ in documents]
    for i, doc in enumerate(documents):
        for kw in keywords:
            cnt = doc.count(kw)
            if cnt > 0:
                tf_dict[i][kw] = cnt
    idf_dict = {}
    for kw in keywords:
        occurance = sum(1 for i in range(len(documents)) if kw in tf_dict[i])
        if occurance > 0:
            idf_dict[kw] = len(documents) / occurance
    return tf_dict, idf_dict

def rank_keywords(documents, keywords, threshold=2):
    tf_dict, idf_dict = tf_idf_dict(documents, keywords)
    ret = []
    def formula(kw, freq):
        # return math.log(freq + 1) * math.log(idf_dict[kw] + 1)
        return 1 * math.log(idf_dict[kw] + 1)
    for tf in tf_dict:
        scores = {k: formula(k, freq) for k, freq in tf.items()}
        ret.append([x[0] for x in sorted(scores.items(), key=lambda x: -x[1]) if x[1] > threshold])
    return ret

if __name__ == '__main__':
    subtitle_filename = config.context_folder_path + '/' + config.file_name
    concept_filename = config.Evaluation.gold_filename
    subtitles, concepts = load_file(subtitle_filename, concept_filename)
    results = rank_keywords(subtitles, concepts)
    for subtitle, result in zip(subtitles, results):
        # print(subtitle)
        print(result)