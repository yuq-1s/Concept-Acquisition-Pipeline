pip install -r requirements.txt
mkdir processed_data/crawler_results
mkdir word_clustering/word_vectors
wget 'https://cloud.tsinghua.edu.cn/f/0c685ffb5fad4f6c9891/?dl=1' -O crawler_results.zip
unzip crawler_results.zip
wget 'https://cloud.tsinghua.edu.cn/f/a25be37fbab84b5e9c3b/?dl=1' -O word_clustering/word_vectors/sgns.baidubaike.bigram-char
# set `experiment = ''` in config.py
python confidence_prop.py -l zh -task extract --algorithm=tf_idf -nf
python xlink.py
mv processed_data/propagation_results/baike_context_tf_idf_baike_context_xlore_seed_nf_result.json processed_data/propagation_results/baike_context_tf_idf_xlore_seed_nf_result.json
# set `experiment = 'tf_idf'` in config.py
python rerank.py
python clustering.py
