package JiftyX::CloudTags;

use warnings;
use strict;
use Mouse;
use JiftyX::ModelHelpers;

our $VERSION = '0.01';

has 'collection'          => ( is => 'rw', isa => 'Object' );
has 'args'                => (
    is => 'rw',
    isa => 'HashRef'
);

has 'default_link_format' => ( 
    is => 'rw', 
    isa => 'Str' , 
    default => '?id=%i&text=%t&custom=%{hit}'
);

sub set_tags {
    my $self             = shift;
    my $collection_class = shift;
    my %args             = @_;


    my $collection;
    if( ref $collection_class ) {
        $collection = $collection_class;
    }
    else {
        $collection = M($collection_class);
        $collection->unlimit;
    }
    $collection->order_by( column => $args{text_by}, order => 'desc' );
    $self->collection( $collection );
    $self->args( \%args );
}

sub find_boundary {
    my $collection = shift;
    my $size_by    = shift;
    my ( $min_boundary, $max_boundary ) = ( 0, 0 );
    while( my $c = $collection->next ) {
        my $size = ( ref $c->$size_by ? $c->$size_by->count : $c->$size_by );
        $min_boundary = $size if( $size < $min_boundary );
        $max_boundary = $size if( $size > $max_boundary );
    };
    return ( $min_boundary, $max_boundary );
}


sub render {
    my $self = shift;
    my $collection = $self->collection;
    my %args = %{ $self->args };
    my $link_format = $args{link_format} || $self->default_link_format;

    # $args{text_by} 
    # text_by => 'name',
    # size_by => 'related_posts',
    # link_format => '',

    my $min_fontsize = $args{min_fontsize} || 9;
    my $max_fontsize = $args{max_fontsize} || 48;
    my $fontsize_degree = $args{fontsize_degree}
                    || ( $max_fontsize - $min_fontsize );

    my ( $min_boundary , $max_boundary );
    $min_boundary ||= $args{min_boundary};
    $max_boundary ||= $args{max_boundary};
    unless( $min_boundary || $max_boundary ) {
        ( $min_boundary , $max_boundary ) = find_boundary( $collection , $args{size_by} );
    }

    my $degree = $fontsize_degree / ( $max_boundary - $min_boundary )  ;

    my $offset = 0;
    my $div_width = 200;

    my $output = '';
    while( my $c = $collection->next ) {
        my ( $text_acc, $size_acc ) = ( $args{text_by}, $args{size_by} );

        my $id = $c->id;
        my $text = $c->$text_acc;
        my $size = ( ref $c->$size_acc ? $c->$size_acc->count : $c->size_acc );
        my $fontsize = int( $size * $degree + $min_fontsize );

        my $url = $link_format;
        $url =~ s/%i/$id/g;
        $url =~ s/%t/$text/g;

        # custom column
        $url =~ s/\%\{(\w+)\}/ $c->$1 /eg;

        # my $url = 
        $output .= qq|
            <span class="cloudtags" style="font-size: ${fontsize}px;">
                <a href="$url">$text</a>
            </span>
        |;

        $offset += length($text) * $fontsize;
        if( $offset > $div_width ) {
            $output .= q|<br/>|; 
            $offset = 0;
        }
    }

    $output;
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

=head2 set_tags

=head2 find_boundary

=head2 render 


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
