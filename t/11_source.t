use strict;
use warnings;
use Test::More;
use WWW::MetXML::Source;

my $wms = WWW::MetXML::Source->new;
isa_ok $wms, 'WWW::MetXML::Source';
can_ok $wms, qw/sources source source_ids id_to_name/;
isa_ok $wms->sources, 'XML::XPath::NodeSet';

my $amedas = $wms->source('amedas');
isa_ok $amedas, 'XML::XPath::Node::Element';
is join(',', $wms->source_ids), 'aclima,amedas,fieldserver,hitsujigaoka,kanagawa,mamedas,noaa,prefmetdb,snuwdms,wakayama,ThaiFs,sasa,GD-DR&TR,WRDC,fawn,gaemn,oregonIPPC';
is $wms->id_to_name('amedas'), 'AmeDAS(Japan)';

done_testing;
