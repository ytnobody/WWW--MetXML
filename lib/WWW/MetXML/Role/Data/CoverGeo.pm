package WWW::MetXML::Role::Data::CoverGeo;
use strict;
use warnings;
use parent 'Exporter';

our @EXPORT = qw/cover_geo/;

sub cover_geo {
    my $self = shift;
    my $source = $self->{source};
    my $childs = $source->getChildNodes;
    for my $child (@$childs) {
        next unless $child->getName;
        next unless $child->getName eq 'area';
        my $nw_point = $self->coordinates(
            lat    => $child->getAttribute('nw_lat'),
            lng    => $child->getAttribute('nw_lon'),
        );
        my $se_point = $self->coordinates(
            lat    => $child->getAttribute('se_lat'),
            lng    => $child->getAttribute('se_lon'),
        );
        return +{ nw => $nw_point, se => $se_point };
    }
}

1;
