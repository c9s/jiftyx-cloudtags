package JiftyX::CloudTags;

use warnings;
use strict;
use Mouse;
use JiftyX::ModelHelpers;

our $VERSION = '0.01';

has 'collection'          => ( is => 'rw', isa => 'Object' );
has 'default_link_format' => ( 
    is => 'rw', 
    isa => 'Str' , 
    default => '${id} ${text}'
);

sub set_tags {
    my $self       = shift;
    my $collection_class = shift;
    my %args       = @_;

    my $collection;
    if( ref $collection_class ) {
        $collection = $collection_class;
    }
    else {
        $collection = M($collection_class);
        $collection->unlimit;
    }
    $self->collection( $collection );

    $collection->order_by( column => $args{text_by}, order => 'desc' );

    my $link_format = $args{link_format} || $self->default_link_format;

    # $args{text_by} 
    # text_by => 'name',
    # size_by => 'related_posts',
    # link_format => '',

    my $min_size = 9;
    my $max_size = 48;

    my $output = '';
    while( my $c = $collection->next ) {
        my $acc = $args{text_by};
        warn $c->$acc;
    }
}


sub render {
    my $self = shift;
    # $self->collection;
}

1; 

__END__

=head1 NAME

JiftyX::CloudTags 

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use JiftyX::CloudTags;

    my $labels = MyApp::LabelCollection->new( );
    $labels->unlimit;
    
    my $cloudtag = JiftyX::CloudTags->new(  $labels  ,
        text_by => 'name',
        size_by => 'related_posts',
        link_format => '',
    );
    $cloudtag->render;

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS


=head1 AUTHOR

Cornelius, C<< <cornelius.howl at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-jiftyx-cloudtags at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=JiftyX-CloudTags>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc JiftyX::CloudTags


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=JiftyX-CloudTags>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/JiftyX-CloudTags>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/JiftyX-CloudTags>

=item * Search CPAN

L<http://search.cpan.org/dist/JiftyX-CloudTags/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Cornelius, all rights reserved.

This program is released under the following license: GPL

=cut
