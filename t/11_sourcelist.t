use strict;
use warnings;
use Test::More;
use WWW::MetXML::SourceList;
use Geo::Coordinates::Converter::Point;

my $wms = WWW::MetXML::SourceList->new(lang => 'en');
isa_ok $wms, 'WWW::MetXML::SourceList';
can_ok $wms, qw/items item item_ids items_by_geo/;
is $wms->items, 17;

my $amedas = $wms->item('amedas');
isa_ok $amedas, 'WWW::MetXML::SourceList::Data';
is join(',', $wms->item_ids), 'aclima,amedas,fieldserver,hitsujigaoka,kanagawa,mamedas,noaa,prefmetdb,snuwdms,wakayama,ThaiFs,sasa,GD-DR&TR,WRDC,fawn,gaemn,oregonIPPC';

is $amedas->name, 'AmeDAS(Japan)';
is_deeply($amedas->cover_geo, +{ 
    nw => Geo::Coordinates::Converter::Point->new({lat => "46.0", lng => "122.0", datum => "wgs84", format => "degree"}),
    se => Geo::Coordinates::Converter::Point->new({lat => "20.0", lng => "146.0", datum => "wgs84", format => "degree"}),
});

is $amedas->attr('id'), 'amedas';

my @avail = $wms->items_by_geo(lat => '39.0', lng => '139.0');
is join(',', map{$_->name} @avail), 'ACLIMA(Japan),AmeDAS(Japan),Filed Server(Hourly),NOAA/WMO,Global Dataset of DR and TR,Daily Radiation from WRDC';

done_testing;
