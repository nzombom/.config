chomp;
my $lesc = "__BASH_LESC__";
my $resc = "__BASH_RESC__";
my $resetfg = "${lesc}\e[39m${resc}";
my $resetbg = "${lesc}\e[49m${resc}";

# edit values
my $textfg = "${lesc}\e[91m${resc}";
my @colors = (
	"${lesc}\e[90m${resc}",
	"${lesc}\e[100m${resc}",
	"${lesc}\e[30m${resc}",
	"${lesc}\e[40m${resc}",
);
my $maxDirs = 8;

my @strs = /^(?=\/)|[^\/]+/g;
if (@strs > $maxDirs) {
	@strs = ("...", @strs[@array - $maxDirs + 1..$#array]);
}
print map {
	"$colors[($_ * 2) % @colors]$textfg$colors[($_ * 2 + 1) % @colors] $strs[$_] "
} (0..$#strs);
print "$colors[($#strs * 2) % @colors]$resetbg$resetfg";
