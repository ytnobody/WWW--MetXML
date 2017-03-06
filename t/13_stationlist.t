use strict;
use warnings;
use Test::More;
use WWW::MetXML::StationList;
use Geo::Coordinates::Converter::Point;

my $amedas_hokkaido = WWW::MetXML::StationList->new(
    source     => 'amedas:01', 
    elements   => [qw/airtemperature rain/],
    resolugion => 'daily',
);

isa_ok $amedas_hokkaido, 'WWW::MetXML::StationList';
like $_, qr/^[0-9]+$/ for $amedas_hokkaido->item_ids;

my $urahoro = $amedas_hokkaido->item('20506');
isa_ok $urahoro, 'WWW::MetXML::StationList::Data';
is $urahoro->name, 'Urahoro';

my $operational = $urahoro->element('//operational');
isa_ok $operational, 'WWW::MetXML::Component::Data';
is $operational->attr('start'), '1976/04/01 0:00:00';

my @elements = $urahoro->element('//element');
is join(',', map{$_->attr('id')} @elements), 'air temperature,rain,wind,bright sunlight';

my $coordinates = $urahoro->place;
isa_ok $coordinates, 'Geo::Coordinates::Converter::Point';
is_deeply( $coordinates, 
    bless( {
        datum  => 'wgs84',
        format => 'degree',
        height => '20.0',
        lat    => '42.80833435058594',
        lng    => '143.6566619873047'
    }, 'Geo::Coordinates::Converter::Point' )
);

done_testing;
