package WWW::MetXML::Source::Data;
use strict;
use warnings;
use parent 'WWW::MetXML::Component::Data';
use WWW::MetXML::Role::Data::Name;
use WWW::MetXML::Role::Data::CoverGeo;

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

