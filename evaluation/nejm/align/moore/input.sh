# Adding parallel corpora for IBM 1 model construction.
sent_dir=../processed_data/preprocess/manual_align/input/
out_dir=../processed_data/evaluation/nejm/align/moore/input/
[[ ! -f $out_dir ]] && mkdir -p $out_dir

head -n 100000 /mnt/data/boxiang/wmt18/train/corpus.zh > \
$out_dir/wmt18_zh.snt
head -n 100000 /mnt/data/boxiang/wmt18/train/corpus.en > \
$out_dir/wmt18_en.snt

for f in $sent_dir/doc*; do
	echo $f
	base=$(basename $f)
	stem=${base%.*}
	base=${base/./_}.snt
	
	awk '{print $0" | "v1","NR}' \
	v1=$stem $f > \
	$out_dir/$base
done