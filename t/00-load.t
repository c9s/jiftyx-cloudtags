#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'JiftyX::CloudTags' );
}

diag( "Testing JiftyX::CloudTags $JiftyX::CloudTags::VERSION, Perl $], $^X" );
