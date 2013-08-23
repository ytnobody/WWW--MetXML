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

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Role::Coordinates - Coordinates role

=head1 DESCRIPTION

This is a subclass of Exporter that exports coordinates feature.

=head1 EXPORTS

=head2 coordinates

    my $coord = $self->coordinates( %geo );

Returns Geo::Coordinates::Converter::Point object. %geo is constructor parameter of Geo::Coordintes::Converter::Point.

Default, $geo{datum} = 'wgs84' and, $geo{format} = 'degree'.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head2 SEE ALSO

L<Geo::Coordinates::Converter::Point>

=cut

