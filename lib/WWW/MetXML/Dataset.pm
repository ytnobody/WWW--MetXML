package WWW::MetXML::Dataset;
use strict;
use warnings;
use parent 'WWW::MetXML::Component';
use WWW::MetXML::Role::Items;

our $FILENAME = 'dataset.xml';

sub new {
    my ($class, %opts) = @_;
    my $self = $class->SUPER::new(%opts);
    $self->{interval} = join('-', $self->force_array($self->{interval})) if $self->{interval};
    $self->{elements} = join(',', $self->force_array($self->{elements})) if $self->{elements};
    my $xml_url = $self->{base_url} || $self->base_url. $FILENAME;
    $self->{xpath} = $self->fetch_xml($xml_url, %$self);
    return $self;
}

sub items_query { '//element' }

sub item_query { '//element[@id="%s"]' }

1;

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Dataset - dataset.xml wrapper class for WWW::MetXML

=head1 SYNOPSIS

    my $dataset = WWW::MetXML::Dataset->new(
        source     => 'amedas', 
        station    => '40336', 
        interval   => ['2013/08/02 10:00', '2013/08/02 14:00'],
        elements   => [qw/ airtemperature rain wind /],
        resolution => 'hourly',
    );
    my $temp = $dataset->item('airtemperature'); # $temp isa 'WWW::MetXML::Dataset::Data'
    say $temp->{Ave}{'2013/08/02 12:00'};        # '25.2'


=head1 DESCRIPTION

dataset.xml (http://pc105.narc.affrc.go.jp/metbroker/dataset.xml) is API that returns stored weather data.

This class is subclass of L<WWW::MetXML::Component>.

=head1 ROLES

=over 4

=item L<WWW::MetXML::Role::Items>

=back

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

