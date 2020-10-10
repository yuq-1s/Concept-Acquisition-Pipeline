pip install -r requirements.txt
mkdir processed_data/crawler_results
mkdir word_clustering/word_vectors
wget 'https://cloud.tsinghua.edu.cn/f/0c685ffb5fad4f6c9891/?dl=1' -O crawler_results.zip
unzip crawler_results.zip
wget 'https://cloud.tsinghua.edu.cn/f/a25be37fbab84b5e9c3b/?dl=1' -O word_clustering/word_vectors/sgns.baidubaike.bigram-char

# run with `input_data/seeds/seed_concepts_123456` and `input_data/context/baike_context_123456`
./run.sh 123456
