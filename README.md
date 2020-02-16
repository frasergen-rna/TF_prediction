# TF_prediction

Contains a suite of scripts for predicting transcription factor binding sites in Arabidopsis.

## get_promoter.pl

This scripts extracts -500bp to +100bp of the translational start site of differentially expressed genes. The genes to extract are indicated in the maxtrix file. 

Usage:
    perl get_promoter.pl <Genome fasta file> <Gene annotation GFF3> <Matrix>

Required input are:
1. Genome fasta file
2. gene annotation GFF3 file
3. Matrix file that describes the gene expression value for each stage or sample with rows indicating genes and columns indicating samples. 

## 01.bing_site.pl

This script will assess whether the TF binding site falls within the -500bp to +100bp region

Usage:
    perl 01.bing_site.pl 32E-devo.id.tss Ath_TF_list TFBS_from_FunTFBS_inProm_Ath.gff > 32E-devo.id.bs.xls
    
 

    4.01.bing_site.pl：该脚本用于判断TF结合位点是否落入差异基因TSS -500至100范围内
     运行方法：perl 01.bing_site.pl 32E-devo.id.tss Ath_TF_list TFBS_from_FunTFBS_inProm_Ath.gff > 32E-devo.id.bs.xls
     32E-devo.id.tss：文件为基因TSS -500至100范围位置信息
     Ath_TF_list：TF与其结合基因
     TFBS_from_FunTFBS_inProm_Ath.gff：TF结合位点信息
