package WWW::MetXML::Dataset::Data;
use strict;
use warnings;
use parent 'WWW::MetXML::Component::Data';
use WWW::MetXML::Role::Date;

sub data {
    my $self = shift;
    my $rtn = {};
    my @subelements = $self->element('//subelement');
    for my $subelement ( @subelements ) {
        my $key = $subelement->attr('id');
        my @values = $subelement->element('//value');
        $rtn->{$key} = { map {($self->normalize_date($_->attr('date')) => $_->text)} @values };
    }
    return $rtn;
}

1;

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Dataset::Data - Data class of WWW::MetXML::Dataset

=head1 DESCRIPTION

This class expresses weather data element, and it is subclass of WWW::MetXML::Component::Data.

=head1 ORIGINAL METHOD

=head2 data 

Returns weather data as hashref.

=head1 ROLES

=over 4

=item L<WWW::MetXML::Role::Date>

=back

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

