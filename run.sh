echo "cp config_nil.py"
cp config_nil.py config.py
echo "python confidence_prop.py"
python confidence_prop.py -l zh -task extract --algorithm=tf_idf -nf
echo "python xlink.py"
python xlink.py
echo "mv processed_data"
mv processed_data/propagation_results/baike_context_tf_idf_baike_context_more_seed_nf_result.json processed_data/propagation_results/baike_context_tf_idfmore_seed_nf_result.json
echo "cp config_idf.py"
cp config_idf.py config.py
echo "python rerank.py"
python rerank.py
echo "python clustering.py"
python clustering.py

# $1代表course_id
mv processed_data/cluster_results/baike_context_tf_idfmore_seed_nf_cluster_result.json processed_data/cluster_results/baike_context_tf_idfmore_seed_nf_cluster_result_"$1".json
mv processed_data/propagation_results/baike_context_tf_idfmore_seed_nf_result.json processed_data/propagation_results/baike_context_tf_idfmore_seed_nf_result_"$1".json
mv processed_data/rerank_results/baike_context_tf_idfmore_seed_nf_rerank_result.json processed_data/rerank_results/baike_context_tf_idfmore_seed_nf_rerank_result_"$1".json
mv processed_data/xlink_results/baike_context processed_data/xlink_results/baike_context_"$1"
