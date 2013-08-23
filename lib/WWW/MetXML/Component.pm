package WWW::MetXML::Component;
use strict;
use warnings;
use WWW::MetXML::Role::Agent;
use WWW::MetXML::Role::Coordinates;
use WWW::MetXML::Role::XML;
use WWW::MetXML::Role::ForceArray;
use Module::Load ();
use URI;
use Carp;

sub new {
    my ($class, %opts) = @_;
    bless {%opts}, $class;
}

sub lang {
    my $self = shift;
    return $self->{lang} || 'en';
}

sub fetch_xml {
    my ($self, $url, %params) = @_;
    my $uri = URI->new($url);
    $uri->query_form(%params, lang => $self->lang);
    my $res = $self->agent->get($uri->as_string);
    croak($res->status_line) unless $res->is_success;
    return $self->xml($res->content);
}

sub data_object {
    my ($self, $xml) = @_;
    my $class = $self->data_class;
    return $class->new($xml);
}

sub data_class {
    my $self = shift;
    my $class = ref($self);
    my $data_class = $class.'::Data';
    Module::Load::load($data_class) unless $data_class->can('new');
    return $data_class;
}

1;

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Component - Basic component class for WWW::MetXML

=head1 DESCRIPTION

WWW::MetXML::Component is parent class of following classes.

=over 4

=item L<WWW::MetXML::Source>

=item L<WWW::MetXML::Region>

=item L<WWW::MetXML::Station>

=item L<WWW::MetXML::Dataset>

=back

If new MetXML API will released, You can develop subclass of this class for wrapping new API.

=head1 ORIGINAL METHODS

=head2 new

Constructor method. 

=head2 lang

Getter method for "lang" property.

=head2 fetch_xml

    my $xml_xpath = $component->fetch_xml( $xml_url, %query_params );

Send HTTP get request to $xml_url with %query_params. Then, returns response content as XML::XPath object.

=head2 data_object

    my $data_obejct = $component->data_object( $xml_xpath );

Wrap XML::XPath object into data class. Fully name of data class is $component->data_class.

See L<WWW::MetXML::Component::Data> to more information about data class.

=head2 data_class

Returns fully name of data class. 

=head1 ROLES

=over 4

=item L<WWW::MetXML::Role::Agent>

=item L<WWW::MetXML::Role::Coordinates>

=item L<WWW::MetXML::Role::XML>

=item L<WWW::MetXML::Role::ForceArray>

=back

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

