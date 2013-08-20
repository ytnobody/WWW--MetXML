package WWW::MetXML::Role::ItemsByGeo;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION = "0.01";
our @EXPORT = qw/items_by_geo/;

sub items_by_geo {
    my ($self, %geo) = @_;
    my $point = $geo{point} || $self->coordinates(%geo);
    my @items = grep { 
        $_->cover_geo->{nw}->lat ne 'NaN' &&
        $_->cover_geo->{nw}->lng ne 'NaN' &&
        $_->cover_geo->{se}->lat ne 'NaN' &&
        $_->cover_geo->{se}->lng ne 'NaN' ;
    } $self->items;
    return grep { 
        $_->cover_geo->{se}->lat <= $point->lat &&
        $_->cover_geo->{nw}->lat >= $point->lat &&
        $_->cover_geo->{nw}->lng <= $point->lng &&
        $_->cover_geo->{se}->lng >= $point->lng ;
    } @items;
}

1;
