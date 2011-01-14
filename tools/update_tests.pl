#!perl
use strict;
use warnings;
use FindBin;
use LWP::Simple;
use Archive::Tar;
use YAML::Tiny;
use Path::Extended;
use lib "$FindBin::Bin/../lib";

my %map = qw(
  02 Docomo
  03 Jphone
  04 Ezweb
  06 Nonmobile
  07 Airh
  09 Vodafone
  10 Softbank
);

my $archive = "$FindBin::Bin/HTTP-MobileAgent.tar.gz";
my $yaml = get('http://cpanmetadb.appspot.com/v1.0/package/HTTP::MobileAgent');
my $dist = YAML::Tiny::Load($yaml)->{distfile};
mirror("http://cpan.tcool.org/mirror/authors/id/$dist", $archive);
my $tar = Archive::Tar->new($archive);
for my $file ($tar->list_files) {
  my ($id) = $file =~ m{t/(\d+)\w+\.t$};
  next unless $id && $map{$id};
  my $name = $map{$id};
  my $content = $tar->get_content($file);
  my ($data) = $content =~ /__END__\n(.+)$/s;
  my $package = "Test::MobileAgent\::$name";
  eval "require $package" or die $@;
  my @list = split /[\015\012]+/, $package->_list();
  my $dirty;
  for my $agent (split /[\015\012]+/, $data) {
    unless (grep { $_ eq $agent } @list) {
      push @list, $agent;
      $dirty = 1;
    }
  }
  if ($dirty) {
    print "updated $name.pm\n";
    my $new_list = join "\n", grep { defined } @list;
    my $source = file("$FindBin::Bin/templates/$name.pm")->slurp;
    $source =~ s/\n__LIST__/$new_list/s;
    $source =~ s/__DATE__/localtime/se;
    file("$FindBin::Bin/../lib/Test/MobileAgent/$name.pm")->save($source);
  }
}
