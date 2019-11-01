moses="/Users/boxiang/Documents/work/Baidu/projects/mosesdecoder/scripts/tokenizer/"
lowercase="$moses/lowercase.perl"
normalize="$moses/normalize-punctuation.perl"

in_dir="/Users/boxiang/Documents/work/Baidu/projects/med_translation/processed_data/crawler/nejm/articles/"
out_dir="/Users/boxiang/Documents/work/Baidu/projects/med_translation/processed_data/preprocess/articles_norm/"
mkdir -p $out_dir

for f in $in_dir/*/*/*.en; do
	out_fn=$(basename $f)
	if [[ -f $out_dir/$out_fn ]]; then
		echo "File $f exists."
	else
		cat $f | $lowercase | $normalize > $out_dir/$out_fn
	fi
done

for f in $in_dir/*/*/*.zh; do
	out_fn=$(basename $f)
	if [[ -f $out_dir/$out_fn ]]; then
		echo "File $f exists."
	else
		cat $f | $lowercase > $out_dir/$out_fn
	fi
done