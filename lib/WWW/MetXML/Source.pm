package WWW::MetXML::Source;
use strict;
use warnings;

use parent 'WWW::MetXML::Component';

our $VERSION = "0.01";
our $base_url = 'http://pc105.narc.affrc.go.jp/metbroker/sourcelist.xml';

sub new {
    my ($class, %opts) = @_;
    my $self = $class->SUPER::new(%opts);
    my $xml_url = $opts{base_url} || $base_url;
    $self->{xpath} = $self->fetch_xml($xml_url);
    return $self;
}

sub sources {
    my $self = shift;
    my $sources = $self->{xpath}->find('/sources/source');
    my @rtn;
    while (my $row = $sources->shift) {
        push @rtn, $self->data_object($row);
    }
    return @rtn;
}

sub source {
    my ($self, $id) = @_;
    my $query = sprintf('/sources/source[@id="%s"]', $id);
    my $row = $self->{xpath}->find($query)->shift;
    return $self->data_object($row);
}

sub source_ids {
    my $self = shift;
    my @sources = $self->sources;
    return map {$_->attr('id')} @sources;
}

sub sources_by_geo {
    my ($self, %geo) = @_;
    my $point = $geo{point} || $self->coordinates(%geo);
    return grep { 
        $_->cover_geo->{se}->lat <= $point->lat &&
        $_->cover_geo->{nw}->lat >= $point->lat &&
        $_->cover_geo->{nw}->lng <= $point->lng &&
        $_->cover_geo->{se}->lng >= $point->lng ;
    } $self->sources;
}

1;

=encoding utf-8

=head1 NAME

WWW::MetXML::Source - Data-Source Class for WWW::MetXML

=head1 SYNOPSIS

    use WWW::MetXML::Source;
    my $wms = WWW::MetXML::Source->new(lang => 'en');  # default lang = 'en'
    my @sources = $wms->sources;                       # @sources contains WWW::MetXML::Source::Data objects
    my $amedas  = $wml->source('amedas');              # $amedas is a WWW::MetXML::Source::Data object
    say $amedas->name;                                 # 'AmeDAS(Japan)'
    my $geo   = $amedas->cover_geo;                    # { nw => Geo::Coordinates::Converter::Point, se => Geo::Coordinates::Converter::Point };
    my @avail = $wms->sources_from_geo(                # @avail contains WWW::MetXML::Source::Data objects that coveres specified latitude/longitude point
        lat => ..., lng => ...
    );

=head1 DESCRIPTION

This class manipulates data-source xml of MetXML. 

=head1 METHODS

=head2 new 

Constructor for WWW::MetXML::Source.

Attributes are followings.

=over 4

=item lang

Data language. You may choose from 'ja' or 'en'. Default is 'en'.

=item base_url

URL for API. Default is 'http://pc105.narc.affrc.go.jp/metbroker/sourcelist.xml'.

=back

=head2 sources

Returns all sources as array that contains WWW::MetXML::Source::Data object.

=head2 source

Returns a WWW::MetXML::Source::Data object that has specified id.

=head2 source_ids

Returns all source id as array.

=head2 sources_by_geo

Returns sources object that matches specified coordinates.

You may specify coordinates in Geo::Coordinates::Converter::Point object like as following,

    my $point = Geo::Coordinates::Converter::Point->new(...);
    my @matched = $wms->sources_by_geo(point => $point);

Or, like as following.

    ### default is datum = 'wgs84', format = 'degree'
    my @matched = $wms->sources_by_geo(lat => ..., lng => ..., datum => ..., format => ...);

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

L<WWW::MetXML::Component>

L<WWW::MetXML::Source::Data>

=cut
 
