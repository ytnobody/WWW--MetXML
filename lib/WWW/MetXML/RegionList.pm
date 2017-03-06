package WWW::MetXML::RegionList;
use strict;
use warnings;
use parent 'WWW::MetXML::Component';
use WWW::MetXML::Role::Items;
use WWW::MetXML::Role::ItemsByGeo;
use WWW::MetXML::Role::ForceArray;

our $VERSION = 0.01;
our $FILENAME = 'regionlist.xml';

sub new {
    my ($class, %opts) = @_;
    my $self = $class->SUPER::new(%opts);
    my $xml_url = $self->{base_url} || $self->base_url. $FILENAME;
    $self->{xpath} = $self->fetch_xml($xml_url, source => join(',', $self->force_array($self->{source})));
    return $self;
}

sub items_query { '/regions/source/region' }

sub item_query { '/regions/source/region[@id="%s"]' }

1;

__END__

=encoding utf-8

=head1 NAME

WWW::MetXML::Region - regionlist.xml wrapper class for WWW::MetXML

=head1 DESCRIPTION

regionlist.xml (http://pc105.narc.affrc.go.jp/metbroker/regionlist.xml) is API that returns region list.

This class is subclass of L<WWW::MetXML::Component>.

=head1 ROLES

=over 4

=item L<WWW::MetXML::Role::Items>

=item L<WWW::MetXML::Role::ItemsByGeo>

=item L<WWW::MetXML::Role::ForceArray>

=back

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut


