open IN,"$ARGV[0]";
while(<IN>){
	chomp;
	@c=split/\t/;
	if($c[2]=~/^mRNA$/ || $c[2]=~/^ncRNA$/ || $c[2]=~/^mRNA_TE_gene$/ || $c[2]=~/^miRNA$/ || $c[2]=~/^rRNA$/ || $c[2]=~/^snRNA$/){
		$id=(split/,|;/,$c[-1])[0];
		$id=~s/ID=//g;
		$loci=(split/\./,$id)[0];
		if(!defined $mark{$id}){
			$son{$loci}.="$id;";
			$mark{$id};
		}
		$cds{$id}.="$c[3],$c[4];";
		$chr{$loci}=$c[0];
		$str{$loci}=$c[6];
	}
}
close IN;
open FA,"$ARGV[1]";
my %hash;
$/=">";
while(<FA>){
        chomp;
        while(<FA>){
                chomp;
                my ($qid,$seq)=split/\n/,$_,2;
                @id=split/\s+/,$qid;
                $seq=~s/\s+//g;
                $hash{$id[0]}=$seq;
        }
}
$/="\n";
close FA;
open LIST,"$ARGV[2]";
$name=(split/\//,$ARGV[2])[-1];
$name=~s/.xls//g;
open O,">$name.tss";
print O "Gene\tTranscript\tChr\tStrand\tTSS\tPromoter\n";
open O2,">$name.promoter.fa";
while(<LIST>){
	chomp;
	$id=(split/\t/)[0];
	if($id!~/^AT/){next};
	$hash{$id}=1;
	if(exists $son{$id}){
		@trans=split/;/,$son{$id};
		for $t(@trans){
			$cds{$t}=~s/;$//g;
			($s,$e)=(split/;|,/,$cds{$t})[0,-1];
			if($str{$id}=~/-/){
				if($s>$e){
					$tss=$s;
				}else{
					$tss=$e;
				}
			}else{
				if($s<$e){
					$tss=$s;
				}else{
					$tss=$e;
				}
			}
			#print O "$id\t$t\t$chr{$id}\t$str{$id}\t$tss\t$cds{$t}\n";
			if($str{$id}=~/-/){
				$sta=$tss-100;
				$end=$tss+500;
			}else{
				$sta=$tss-500;
				$end=$tss+100;
			}
			print O "$id\t$t\t$chr{$id}\t$str{$id}\t$tss\t$sta,$end\n";
			if(!defined $mark{$id}{$tss}){
				$mark{$id}{$tss}=1;
				if(exists $hash{$chr{$id}}){
					$gen=substr($hash{$chr{$id}},$sta-1,$end-$sta+1);
				}
				if($str{$id}=~/-/=~/-/){
					$gene=reverse($gen);
					$gene=~tr/ATCGatcg/TAGCtagc/;
				}else{
					$gene=$gen;
				}	
				print O2 ">$id $tss\n$gene\n";
			}
		}
	}else{
		print "$_\n";	#non-coding gene
	}
}
close LIST;
