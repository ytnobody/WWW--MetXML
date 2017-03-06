use strict;
use warnings;
use Test::More;
use WWW::MetXML::AreaStation;
use Geo::Coordinates::Converter::Point;

my $area_station = WWW::MetXML::AreaStation->new(
    area => { 
        nw => {lat => '36.44', lng => '139.82'}, 
        se => {lat => '35.55', lng => '140.17'},
    } 
);
isa_ok $area_station, 'WWW::MetXML::AreaStation';
like $_, qr/^[0-9\-]+$/ for $area_station->item_ids;
my $tsukubasan = $area_station->item('40243');
isa_ok $tsukubasan, 'WWW::MetXML::AreaStation::Data';
is $tsukubasan->name, 'Tsukubasan';
is_deeply($tsukubasan->place, 
    bless( {
        datum  => 'wgs84',
        format => 'degree',
        height => '868.0',
        lat    => '36.223331451416016',
        lng    => '140.10166931152344'
    }, 'Geo::Coordinates::Converter::Point' )
);

done_testing;
