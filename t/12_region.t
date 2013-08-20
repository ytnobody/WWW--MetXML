use strict;
use warnings;
use Test::More;
use WWW::MetXML::Region;
use Geo::Coordinates::Converter::Point;

my $wmr = WWW::MetXML::Region->new(lang => 'en', source => 'amedas');
isa_ok $wmr, 'WWW::MetXML::Region';
can_ok $wmr, qw/items item item_ids items_by_geo/;

my @items = $wmr->items;
is @items, 47;
isa_ok $items[0], 'WWW::MetXML::Region::Data';

my $item = $wmr->item('02');
isa_ok $item, 'WWW::MetXML::Region::Data';
is $item->name, 'Aomoriken';

is_deeply($item->cover_geo, {
    nw => Geo::Coordinates::Converter::Point->new({lat => "41.526668548583984", lng => "139.93167114257812", datum => 'wgs84', format => 'degree' }),
    se => Geo::Coordinates::Converter::Point->new({lat => "40.323333740234375", lng => "141.52166748046875", datum => 'wgs84', format => 'degree' }),
});

my $thai_fs    = WWW::MetXML::Region->new(source => 'ThaiFs');
my $chonburi   = $thai_fs->item('20');
my $chantaburi = $thai_fs->item('22');

is_deeply($chonburi->cover_geo, {
    nw => Geo::Coordinates::Converter::Point->new({lat => "13.114800453186035", lng => "101.08200073242188", datum => 'wgs84', format => 'degree' }),
    se => Geo::Coordinates::Converter::Point->new({lat => "12.96619987487793", lng => "101.2699966430664", datum => 'wgs84', format => 'degree' }),
});

is_deeply($chantaburi->cover_geo, {
    nw => Geo::Coordinates::Converter::Point->new({lat => "NaN", lng => "NaN", datum => 'wgs84', format => 'degree' }),
    se => Geo::Coordinates::Converter::Point->new({lat => "NaN", lng => "NaN", datum => 'wgs84', format => 'degree' }),
});


done_testing;
