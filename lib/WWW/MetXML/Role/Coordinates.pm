package WWW::MetXML::Role::Coordinates;
use strict;
use warnings;
use parent 'Exporter';
use Geo::Coordinates::Converter::Point;

our @EXPORT = qw/coordinates/;

sub coordinates {
    my ($self, %geo) = @_;
    $geo{datum}  ||= 'wgs84';
    $geo{format} ||= 'degree';
    return Geo::Coordinates::Converter::Point->new({%geo});
}

1;

