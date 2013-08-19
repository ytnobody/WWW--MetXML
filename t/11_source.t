use strict;
use warnings;
use Test::More;
use WWW::MetXML::Source;

my $wms = WWW::MetXML::Source->new;
isa_ok $wms, 'WWW::MetXML::Source';
can_ok $wms, qw/sources source source_ids id_to_name id_to_geo/;
isa_ok $wms->sources, 'XML::XPath::NodeSet';

my $amedas = $wms->source('amedas');
isa_ok $amedas, 'XML::XPath::Node::Element';
is join(',', $wms->source_ids), 'aclima,amedas,fieldserver,hitsujigaoka,kanagawa,mamedas,noaa,prefmetdb,snuwdms,wakayama,ThaiFs,sasa,GD-DR&TR,WRDC,fawn,gaemn,oregonIPPC';
is $wms->id_to_name('amedas'), 'AmeDAS(Japan)';
my $geo = $wms->id_to_geo('amedas');
is_deeply($geo, +{nw_lat => "46.0", nw_lon => "122.0", se_lat => "20.0", se_lon => "146.0"});

done_testing;
