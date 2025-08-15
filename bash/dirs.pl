chomp;
my $lesc = "__BASH_LESC__";
my $resc = "__BASH_RESC__";
my $textfg = "${lesc}\e[91m${resc}";
my $resetfg = "${lesc}\e[39m${resc}";
my $resetbg = "${lesc}\e[49m${resc}";
my @colors = (
	"${lesc}\e[90m${resc}",
	"${lesc}\e[100m${resc}",
	"${lesc}\e[30m${resc}",
	"${lesc}\e[40m${resc}",
);
my @strs = /^(?=\/)|[^\/]+/g;
if (@strs > 4) {
	@strs = ("...", @strs[@array - 3..$#array]);
}
print map {
	"$colors[($_ * 2) % @colors]$textfg$colors[($_ * 2 + 1) % @colors] $strs[$_] "
} (0..$#strs);
print "$colors[($#strs * 2) % @colors]$resetbg$resetfg \$";
