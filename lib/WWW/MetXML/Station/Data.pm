package WWW::MetXML::Station::Data;
use strict;
use warnings;
use parent 'WWW::MetXML::Component::Data';
use WWW::MetXML::Role::Data::Name;
use WWW::MetXML::Role::Coordinates;
use WWW::MetXML::Role::Date;

sub place {
    my $self = shift;
    my $place = $self->element('//place');
    return $self->coordinates(lat => $place->attr('lat'), lng => $place->attr('lon'), height => $place->attr('alt'));
}

sub operational {
    my $self = shift;
    my $operational = $self->element('//operational');
    my $start = $operational->attr('start');
    my $end   = $operational->attr('end');
    return {
        start => $self->time_piece($start),
        end   => $end ? $self->time_piece($end) : undef,
    };
}


1;
