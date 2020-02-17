# TF_prediction

Contains a suite of scripts for predicting transcription factor binding sites in Arabidopsis.

## get_promoter.pl

This scripts extracts -500bp to +100bp of the translational start site of differentially expressed genes. The genes to extract are indicated in the maxtrix file. 

Usage:
`perl get_promoter.pl Genome_fasta_file Gene_annotation_GFF3 Gene_list`

Required input are:
1. Genome fasta file
2. gene annotation GFF3 file
3. Gene list: a text file that list the gene to analyze. One gene per line. 

## 01.bing_site.pl

This script will assess whether the TF binding site falls within the -500bp to +100bp region

Usage:
`perl 01.bing_site.pl promoter_region Ath_TF_list TFBS_from_FunTFBS_inProm_Ath.gff`

Required input are:
1. Promoter_region. Usually the output of get_promoter.pl
2. List of transcription factors. See example for file format
3. TFBS_from_FunTFBS_inProm_Ath.gff is the TF binding site information. See example for file format. 
 
 
