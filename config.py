import os

# experiment = 'average_distance_'
experiment = 'tf_idf_'
# experiment = 'graph_prop_'
# experiment = 'pagerank_'
video_context = False
# experiment = ''

# parsed baike context of seed concepts
baike_context = 'input_data/concept_baike/parsed_concept_baidu_1.json'
seed_folder_path = 'input_data/seeds'
context_folder_path = 'input_data/context'

# default paths
zh_list = 'processed_data/crawler_results/zh_list'
en_list = 'processed_data/crawler_results/en_list'
db = 'snippet.db'
cookie_paths = ['crawler/cookie/{}'.format(file) for file in os.listdir('crawler/cookie/')]

# tmp paths
tmp_input_text = 'tmp/input_text.txt'
tmp_middle_res = 'tmp/middle_res.txt'

# default paramters
proxy = {'http': 'http://localhost:8001', 'https': 'http://localhost:8001'}  # should change to your own proxy
bert_client_ip = None
input_text = 'input_data/context/baike_context'
input_seed = 'input_data/seeds/seed_concepts'
# input_seed = 'input_data/seeds/xlore_seeds.txt'
language = 'zh'
snippet_source = 'baidu'
times = None
max_num = None
threshold = None
decay = None
no_seed =  False

seed = 'more_seed_' if input_seed.endswith('seed_concepts') else 'xlore_seed_'

context_prefix = 'baike_context_' if not video_context else 'dsa_video_context_'
result_path = f'processed_data/propagation_results/{context_prefix}{experiment}{seed}nf_result.json'
rerank_result_path = f"processed_data/rerank_results/{context_prefix}{experiment}{seed}nf_rerank_result.json"
cluster_concept_path = f"processed_data/rerank_results/{context_prefix}{experiment}{seed}nf_rerank_result.json"
cluster_save_path = f"processed_data/cluster_results/{context_prefix}{experiment}{seed}nf_cluster_result.json"

# Xlink related settings

url  =  "http://166.111.68.66:9068/EntityLinkingWeb/linkingSubmit.action"
# url = "http://10.1.1.68:8081/EntityLinkingWeb/linkingSubmit.action"
lang = "zh" 
 # "zh" for extract Chinese concepts, "en" for English
folder_path = "input_data/context" 
# file_name = "baike_context"
file_name = "dsa_video_context"
save_folder = "processed_data/xlink_results" 


# clustering settings
num_clusters = 15
num_seed_clusters = 10
wordvector_path = "word_clustering/word_vectors/sgns.baidubaike.bigram-char"

# word bag
prun_length = 1000
bag_length = 20
save_word_bag = 'processed_data/word_bag_results/word_bag.json'
word_cut_mode = True

class Evaluation:
    gold_filename = 'annotated-as-seed.json'
    seed_filename = input_seed
    # evaluated_filenames = [
    #     f'processed_data/propagation_results/{experiment}_nf_result.json' for experiment in \
    #     ['tf_idf', 'pagerank', 'graph_prop', 'average_distance']
    # ]
    evaluated_filenames = [
        f'processed_data/rerank_results/{experiment}_nf_rerank_result.json' for experiment in \
        ['tf_idf', 'pagerank', 'graph_prop', 'average_distance']
    ]
    algorithm_names = [
            'average_distance',
            'graph_prop',
            'pagerank',
            'tf_idf',
            'xlink',
            'cluster',
            'rerank']
    relevance_field_names = ['', '', '', '', 'score']
    topks = [100, 200]
    dump_csv = None # 'evaluation_results.csv'
    file2algo = dict(zip(evaluated_filenames, algorithm_names))
