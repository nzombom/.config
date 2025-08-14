use v5.42.0;

my $folders = join(" ", (
	"/usr/share/applications",
	"/home/zombo/.local/share/applications"
));

my $filestr = qx/find $folders -type f -name "*.desktop"/;
my @files;
my @names;
foreach (split(/\n/, $filestr)) {
	push(@files, $_);
	$_ =~ /.*\/(.*)\.desktop/;
	push(@names, $1);
}
my $cNames = join("\\n", @names);
my $dmenuOpts = "-b -i -fn 'JetBrains Mono:size=36' -nb '#202020' -nf '#c0c0c0' -sb '#d05050' -sf '#ffffff'";
my $selection = qx/echo -e "$cNames" | dmenu $dmenuOpts/;
chomp $selection;
chomp(@files);
chomp(@names);
my @idx = grep { $names[$_] eq $selection } (0 .. $#names);
exec "dunstify \"app not found\"" if (@idx < 1);
exec "dex $files[$idx[0]]";
