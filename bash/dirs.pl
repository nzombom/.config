chomp;
my $textfg = "__BASH_LESC_\e[91m_BASH_RESC__";
my $resetbg = "__BASH_LESC_\e[49m_BASH_RESC__";
my @colors = ("__BASH_LESC_\e[90m_BASH_RESC__", "__BASH_LESC_\e[100m_BASH_RESC__", "__BASH_LESC_\e[30m_BASH_RESC__", "__BASH_LESC_\e[40m_BASH_RESC__");
my @strs = /^\/|[^\/]+/g;
print map {
	"$colors[($_ * 2 + 1) % @colors]$textfg $strs[$_] $colors[($_ * 2) % @colors]"
} (0..$#strs);
print "$resetbg";
