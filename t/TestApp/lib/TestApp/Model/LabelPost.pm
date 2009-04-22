use strict;
use warnings;

package TestApp::Model::LabelPost;
use Jifty::DBI::Schema;

use TestApp::Record schema {

column label =>
    refers_to TestApp::Model::Label;

column post =>
    refers_to TestApp::Model::Post;

};

# Your model-specific methods go here.

1;

