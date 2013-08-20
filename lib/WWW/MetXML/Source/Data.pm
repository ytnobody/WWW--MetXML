package WWW::MetXML::Source::Data;
use strict;
use warnings;
use parent 'WWW::MetXML::Component::Data';

sub name {
    my $self = shift;
    my $source = $self->{source};
    my $childs = $source->getChildNodes;
    for my $child (@$childs) {
        next unless $child->getName;
        next unless $child->getName eq 'name';
        return $child->string_value;
    }
}

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

=head1 NAME

WWW::MetXML::Source::Data - Row data of WWW::MetXML::Source

=head1 DESCRIPTION

Object of this class generates by WWW::MetXML::Source object.

=head1 METHODS

=head2 attr

Returns specified attribute.

=head2 name

Returns source name.

=head2 cover_geo

Returns range of coordinates that covers by source.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

L<WWW::MetXML::Component::Data>

L<WWW::MetXML::Source>

=cut

