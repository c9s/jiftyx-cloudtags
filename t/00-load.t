#!perl
use lib 'lib';

use Test::More tests => 1;

BEGIN {
	use_ok( 'JiftyX::CloudTags' );
}

diag( "Testing JiftyX::CloudTags $JiftyX::CloudTags::VERSION, Perl $], $^X" );

my $cloudtags = JiftyX::CloudTags->new;
ok( $cloudtags );
