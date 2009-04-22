#!perl
use lib 'lib';

use Test::More tests => 1;

BEGIN {
	use_ok( 'JiftyX::CloudTags' );
}

diag( "Testing JiftyX::CloudTags $JiftyX::CloudTags::VERSION, Perl $], $^X" );


use JiftyX::CloudTags;
my $cloudtags = new JiftyX::CloudTags;
ok( $cloudtags );
