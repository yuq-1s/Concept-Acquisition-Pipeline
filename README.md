# Concept Acquisition Pipeline

Extract concepts from text with seed concepts.

## Installation

```
pip install -r requirements.txt
mkdir processed_data/crawler_results
mkdir word_clustering/word_vectors
wget 'https://cloud.tsinghua.edu.cn/f/0c685ffb5fad4f6c9891/?dl=1' -O crawler_results.zip
unzip crawler_results.zip
wget 'https://cloud.tsinghua.edu.cn/f/a25be37fbab84b5e9c3b/?dl=1' -O word_clustering/word_vectors/sgns.baidubaike.bigram-char

```

## Usage

Put seed concepts in `input_data/seeds/seed_concepts_123456`, one per line.
Put unstructured text file in `input_data/context/baike_context_123456`.
Currently only works with `tf_idf` and `pagerank` algorithm, see `details.md` for more details.
To run `graph_prop` and `average_distance` algorithm, please refer to [luogan's repository](https://github.com/luogan1234/concept-expansion-snippet).
```
./run.sh 123456
```
see output concepts in `baike_context_tf_idfmore_seed_nf_cluster_result_123456.json`.
