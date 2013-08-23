package WWW::MetXML::Component::Data;
use strict;
use warnings;
use WWW::MetXML::Role::Coordinates;
use WWW::MetXML::Role::XML;

sub new {
    my ($class, $source) = @_;
    bless { source => $source }, $class;
}

sub attr {
    my ($self, $attr) = @_;
    $self->{source}->getAttribute($attr);
}

sub element {
    my ($self, $query) = @_;
    my $root    = $self->xml($self->to_string);
    my $nodeset = $root->find($query);
    my @rtn;
    while (my $node = $nodeset->shift) {
        push @rtn, __PACKAGE__->new($node);
    }
    return wantarray ? @rtn : $rtn[0];
}

sub text {
    my $self = shift;
    return $self->{source}->string_value;
}

sub value {
    shift->text;
}

sub to_string {
    my $self = shift;
    return $self->{source}->toString;
}

1;

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Component::Data - Data class for WWW::MetXML::Component

=head1 DESCRIPTION

Basic data class of component classes for WWW::MetXML.

This class used from WWW::MetXML::Component::Data indirectry.

=head1 ORIGINAL METHODS

=head2 new

    my $xml = '<foo>bar</foo>';
    my $data = WWW::MetXML::Component::Data->new($xml);

Constructor method.

=head2 attr

    my $attr_value = $data->attr( $attr_name );

Returns value of specified attribute.

=head2 element

    my @matched_elements = $data->element('//tagname');
    my $head_element = $data->element('//tagname');

Returns element(s) as WWW::MetXML::Component::Data object that is matched specified XPath.

=head2 text / value

    my $xml = '<foo>bar</foo>';
    my $data = WWW::MetXML::Component::Data->new($xml);
    say $data->text;  # 'bar';

Returns string value. "value" method is alias of "text" method.

=head2 to_string

    my $xml = '<foo>bar</foo>';
    my $data = WWW::MetXML::Component::Data->new($xml);
    say $data->to_string;  # '<foo>bar</foo>';

Returns xml data as string.

=head1 ROLES

=over 4

=item L<WWW::MetXML::Role::Coordinates>

=item L<WWW::MetXML::Role::XML>

=back

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut
