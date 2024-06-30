#!usr/bin/perl

@array = ();

while(<>){
	chomp;	
	push (@array, $_);
}

#---------------------------------------#
# 出力
#---------------------------------------#

$firstline = shift(@array);

foreach(@array){

	%hash = "";
	%wordcount = "";
	@line = ();
	@word = ();

	@line = split(/,/, $_);

	if ($line[0] =~ /"(.+)":\[{/){
		$num = $1;
	}

	foreach(@line){
		if( $_ =~ /"answer":"(.+?)"/ ){
			$hash{$1}++;
		}
	}

	$counter = 0;
	$hindo = 0;
	foreach $key (sort{$hash{$b}<=>$hash{$a}} keys %hash){

		# 頻度の降順でソートし最頻値のAnsを取得
		if($counter==0){
			$saihinwords{$num} = $key;
			$counter++;
		}

		if ($hindo < $hash{$key}) {
			$hindo = $hash{$key};
		}

		@word = split(/ /, $key);
		foreach(@word){
			$wordcount{$_} += $hash{$key};
		}

	}
	
	# 最頻値が4以上の場合は変えない。そのためのKeepフラグを設定。
	if ($hindo > 4){
		$keep{$num} = 1;
	}

	$counter = 0;

	# 最頻値が3以下の時はスペースでsplitし、最頻ワードを抽出。それを10個並べてAnsを置き換える。
	foreach( sort{$wordcount{$b}<=>$wordcount{$a}} keys %wordcount ){

		if($counter==0){
			$saihinword{$num} = $_;
			$counter++;
		}

	}
}

$output = "";
#print "$firstline\n";
$output = $firstline;

foreach $line (@array){

	$saihinanswers = "";
	$saihinanswerss = "";
	$adds = 0;
	@c = ();

	if ($line =~ /"(.+?)":\[{/){
		$num = $1;

		if($keep{$num} == 1){
#			print "$line\n";
#			print "hoge\t$keep{$num}\n";

			@c = split (/},{/, $line);
			$adds = 10 - @c;

			$saihinanswers = "{\"answer_confidence\":\"yes\",\"answer\":\"$saihinwords{$num}\"}";

			unless ($adds == 0){

				for($i=0; $i<$adds; $i++){
					$saihinanswerss .= ",$saihinanswers";
				}

#				print "***$saihinanswers\n";
#				print "***$saihinanswerss\n";
			
				$line =~ s/\]/$saihinanswerss]/;

			}

#			print "$line\n";
			$output .= "$line";
			

		}else{
			$saihinanswer = "{\"answer_confidence\":\"yes\",\"answer\":\"$saihinword{$num}\"}";
#			print "\"$num\":\[$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer],\n";
			$output .= "\"$num\":\[$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer,$saihinanswer],";

		}
	}
}

$output =~ s/}\],$/}\]}}/;
print "$output\n";


