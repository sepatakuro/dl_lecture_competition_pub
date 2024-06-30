#!usr/bin/perl

@array = ();

while(<>){
	chomp;
	$line = $_;
	$line =~ s/},/},\n/g;
	$line =~ s/}],/}\n],\n/g;
	$line =~ s/:\[/:\[\n/g;

	#print $line;
	@array = split(/\n/, $line)

}

#---------------------------------------#
# 出力
#---------------------------------------#

# answer_confidence がnoとmaybeの行を消す。
foreach(@array){

	if ($_ =~ /\"answer_confidence\":\"no\"/){

	}elsif ($_ =~ /\"answer_confidence\":\"maybe\"/){

	}else{
	#	print "$_\n";
		print"$_";
	}

}


