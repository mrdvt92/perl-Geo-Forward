#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper qw{Dumper};
use Test::More tests => 6;
use Geo::Functions qw{deg_dms};

BEGIN { use_ok( 'Geo::Forward' ); }
my $gf = Geo::Forward->new;
isa_ok($gf, "Geo::Forward");

my $bbox = $gf->bbox(34,-77, 1000);

# $VAR1 = {
#           'south' => '33.9909846806412',
#           'north' => '34.0090153061241',
#           'west' => '-77.0108242930311',
#           'east' => '-76.989175706969'
#         };

diag(Dumper($bbox));

ok(near($bbox->{'north'},  '34.0090153061241'));
ok(near($bbox->{'east'},  '-76.9891757069690'));
ok(near($bbox->{'south'},  '33.9909846806412'));
ok(near($bbox->{'west'},  '-77.0108242930311'));

sub near {
  my $x=shift;
  my $y=shift;
  my $p=shift || 10e-7;
  if (($x-$y)/$y < $p) {
    return 1;
  } else {
    return 0;
  }
}
