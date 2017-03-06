package WWW::MetXML::StationList::Data;
use strict;
use warnings;
use parent 'WWW::MetXML::Component::Data';
use WWW::MetXML::Role::Data::Name;
use WWW::MetXML::Role::Coordinates;

sub place {
    my $self = shift;
    my $place = $self->element('//place');
    return $self->coordinates(lat => $place->attr('lat'), lng => $place->attr('lon'), height => $place->attr('alt'));
}

1;
