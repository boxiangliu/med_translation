# The following commands are from Baigong Zheng.

# BPE:
cd /mnt/home/baigong/data/wmt18zh-en/org/
bash preprocess.sh

# Train:
sub 1080Ti_slong 8 z2ebpe "/mnt/home/baigong/scratch_SMT/seqtoseq/train.py -data /mnt/home/baigong/scratch_SMT/seqtoseq/data/wmt18ZE/bpe/data -save_model /mnt/home/baigong/scratch_SMT/seqtoseq/mymodels/zh2en/bpe/model -layers 6 -rnn_size 512 -word_vec_size 512 -transformer_ff 2048 -heads 8  -encoder_type transformer -decoder_type transformer -position_encoding -train_steps 500000  -max_generator_batches 2 -dropout 0.1 -batch_size 4000 -batch_type tokens -normalization tokens  -accum_count 2 -optim adam -adam_beta2 0.997 -decay_method noam -warmup_steps 10000 -learning_rate 2 -max_grad_norm 0 -param_init 0  -param_init_glorot -label_smoothing 0.1 -valid_steps 10000 -save_checkpoint_steps 10000 -gpu_ranks 0 1 2 3 4 5 6 7 -world_size 8 -master_port 10003 -keep_checkpoint 10 -train_from /mnt/home/baigong/scratch_SMT/seqtoseq/mymodels/zh2en/bpe/model_step_300000.pt " /mnt/home/baigong/scratch_SMT/seqtoseq/mymodels/zh2en/bpe/log.txt 
sub 1080Ti_slong 8 e2zbpe "/mnt/home/baigong/scratch_SMT/seqtoseq/train.py -data /mnt/home/baigong/scratch_SMT/seqtoseq/data/wmt18EZ/bpe/data -save_model /mnt/home/baigong/scratch_SMT/seqtoseq/mymodels/en2zh/bpe/model -layers 6 -rnn_size 512 -word_vec_size 512 -transformer_ff 2048 -heads 8  -encoder_type transformer -decoder_type transformer -position_encoding -train_steps 500000  -max_generator_batches 2 -dropout 0.1 -batch_size 2000 -batch_type tokens -normalization tokens  -accum_count 2 -optim adam -adam_beta2 0.997 -decay_method noam -warmup_steps 10000 -learning_rate 2 -max_grad_norm 0 -param_init 0  -param_init_glorot -label_smoothing 0.1 -valid_steps 10000 -save_checkpoint_steps 10000 -gpu_ranks 0 1 2 3 4 5 6 7 -world_size 8 -master_port 10003 -keep_checkpoint 10 -train_from /mnt/home/baigong/scratch_SMT/seqtoseq/mymodels/en2zh/bpe/model_step_280000.pt " /mnt/home/baigong/scratch_SMT/seqtoseq/mymodels/en2zh/bpe/log.txt

# 