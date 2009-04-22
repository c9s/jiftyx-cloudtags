#!/usr/bin/env perl
use warnings;
use strict;

=head1 DESCRIPTION

A basic test harness for the Posts model.

=cut

use Jifty::Test tests => 11;

# Make sure we can load the model
use_ok('TestApp::Model::Posts');

# Grab a system user
my $system_user = TestApp::CurrentUser->superuser;
ok($system_user, "Found a system user");

# Try testing a create
my $o = TestApp::Model::Posts->new(current_user => $system_user);
my ($id) = $o->create();
ok($id, "Posts create returned success");
ok($o->id, "New Posts has valid id set");
is($o->id, $id, "Create returned the right id");

# And another
$o->create();
ok($o->id, "Posts create returned another value");
isnt($o->id, $id, "And it is different from the previous one");

# Searches in general
my $collection =  TestApp::Model::PostsCollection->new(current_user => $system_user);
$collection->unlimit;
is($collection->count, 2, "Finds two records");

# Searches in specific
$collection->limit(column => 'id', value => $o->id);
is($collection->count, 1, "Finds one record with specific id");

# Delete one of them
$o->delete;
$collection->redo_search;
is($collection->count, 0, "Deleted row is gone");

# And the other one is still there
$collection->unlimit;
is($collection->count, 1, "Still one left");

