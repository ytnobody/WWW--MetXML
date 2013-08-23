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

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Role::Data::CoverGeo - cover coordinates range role

=head1 DESCRIPTION

This is a subclass of Exporter that exports a feature about a coordinates range of data accumulation.

=head1 EXPORTS

=head2 cover_geo

    my $coords_range = $self->cover_geo;

Returns coordinates range as hashref.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

