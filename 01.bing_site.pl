open IN,"$ARGV[1]";
while(<IN>){
	chomp;
	($tf,$fam)=(split/\t/)[1,2];
	if(!defined $mark{$tf}{$fam}){
		$mark{$tf}{$fam}=1;
		$fam{$tf}.="$fam;";
	}
}
close IN;
open IN,"$ARGV[2]";
while(<IN>){
	chomp;
	($chr,$s,$e,$strand,$tf,$id)=(split/\t|;|=/)[0,3,4,6,9,11];
	$id{"$chr\t$strand"}.="$id;";
	$s{$id}=$s;
	$e{$id}=$e;
	$tf{$id}=$tf;
}
close IN;

open IN,"$ARGV[0]";
print "Gene\tTF\tTF_family\n";
<IN>;
while(<IN>){
	chomp;
	($gene,$trans,$chr,$strand,$tss,$s,$e)=split/\t|,/;
	if(!defined $mark{$gene}{$tss}){
		@id=(split/;/,$id{"$chr\t$strand"});
		for $id(@id){
			if($s{$id}>$e){
				last;
			}
			if($s{$id}>=$s && $e{$id}<=$e){
				$fam{$tf{$id}}=~s/;$//g;
				#print "$gene\t$trans\t$chr\t$strand\t$tss\t$s,$e\t$id\t$tf{$id}\t$s{$id},$e{$id}\t$fam{$tf{$id}}\n";
				$hash{"$gene\t$tf{$id}\t$fam{$tf{$id}}"}=1;
				
			}
		}
		$mark{$gene}{$tss}=1;
	}
}
close IN;
foreach(sort keys %hash){
	print "$_\n";
}

