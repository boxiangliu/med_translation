############
# Crawling #
############
# Crawl NEJM websites:
python3 crawler/crawl.py 

# Get article type distribution:
python3 crawler/url_stat.py 

# Filter unwanted texts:
python3 crawler/filter.py

# Get length difference before and after filtering:
python3 crawler/article_stat.py

#################
# Preprocessing #
#################
# Preprocess NEJM articles
# Step 1:
# Turn English sentences into lower case and normalize 
# punctuations, also remove :
bash preprocess/normalize.sh

# Step 2:
# Split paragraphs into sentences: 
bash preprocess/detect_sentences/eserix.sh 
python3 preprocess/detect_sentences/punkt.py
python3 preprocess/detect_sentences/sent_stat.py

# Step 3:
# Tokenize sentences and change case:
bash preprocess/tokenize.sh
bash preprocess/lowercase.sh
bash preprocess/truecase.sh

# Step 4:
# Manually align:
bash preprocess/manual_align/copy.sh
bash preprocess/manual_align/align.sh


##################
# WMT18 baseline #
##################
# Build a WMT18 baseline model. 
# Data: WMT18 news translation shared task
# Model: default transformer

# Train zh -> en on WMT18 BPE data:
# Do not run (only run on GPU nodes)
bash translation/wmt18/train.sh

##############
# Evaluation #
##############

#---- Abstracts -----#

# Create a manually aligned gold-standard based on 
# WMT19 Biomedical translation shared task to  
# evaluate bleualign with WMT18 baseline model:
bash evaluation/wmt19_biomed/modifications.sh 

# This will do necessary preprocessing (segmentation, tokenization, BPE)
# and generate sentence-to-sentence translation. Additionally, it will
# also mark each sentence with doc#,# markers.
bash evaluation/wmt19_biomed/translate.sh

# Here I align with Bleualign, Gale-Church, and Moore's IBM 1 model.
bash evaluation/wmt19_biomed/align.sh

# Evaluate precision and recall for different algorithms:
bash evaluation/wmt19_biomed/evaluate.sh


#------ NEJM articles -------#
# Manually aligned gold-standard for NEJM articles:
# Don't run.
bash preprocess/manual_align.sh


# Aligne with Moore's algorithm:
bash evaluation/nejm/align/moore/input.sh
bash evaluation/nejm/align/moore/align.sh

# This will do necessary preprocessing (segmentation, tokenization, BPE)
# and generate sentence-to-sentence translation. Additionally, it will
# also mark each sentence with doc#,# markers.
# Must be run with GPUs. 
bash evaluation/nejm/translate.sh

# Here I align with Bleualign, Gale-Church, and Moore's IBM 1 model.
bash evaluation/nejm/align.sh

# Evaluate precision and recall for different algorithms:
bash evaluation/nejm/evaluate.sh

# Visually compare Precision-Recall across methods:
python3 evaluation/nejm/vis_pr.py

#####################
# Machine Alignment #
#####################
# Use Moore's algorithm to align and create training set:
bash alignment/moore/align.sh


############
# Clean up #
############
# Use bifixer to remove duplicate sentences:
# Don't run (need docker container)
bash clean/concat.sh
bash clean/clean.sh 

##############
# Split data #
##############
# Split data into training, dev, test:
bash split_data/split_train_test.py

#########################
# Crowdsource Alignment #
#########################
# Prepare articles
python3 crowdsource/prep_articles.py


###############
# Translation #
###############
# Testing the WMT18 model on NEJM journal:
python3 translation/wmt18/test.sh


# Fine-tune on NEJM dataset:
python3 translation/nejm/baigong/train.sh


# Test on NEJM dataset:
python3 translation/nejm/baigong/test.sh


#################
# Visualization #
#################

# Make table 1
python3 visulization/tables/tab1/tab1.py