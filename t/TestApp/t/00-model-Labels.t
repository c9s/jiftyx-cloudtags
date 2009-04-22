#!/usr/bin/env perl
use warnings;
use strict;

=head1 DESCRIPTION

A basic test harness for the Labels model.

=cut

use Jifty::Test tests => 11;

# Make sure we can load the model
use_ok('TestApp::Model::Labels');

# Grab a system user
my $system_user = TestApp::CurrentUser->superuser;
ok($system_user, "Found a system user");

# Try testing a create
my $o = TestApp::Model::Labels->new(current_user => $system_user);
my ($id) = $o->create();
ok($id, "Labels create returned success");
ok($o->id, "New Labels has valid id set");
is($o->id, $id, "Create returned the right id");

# And another
$o->create( 
        name => 'A1',
        hit => 20,
);
$o->create(  );


