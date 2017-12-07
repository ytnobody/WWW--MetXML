# NAME

WWW::MetXML - Perl Interface of MetXML(MetBroker XML)

# SYNOPSIS

    use WWW::MetXML;
    
    my $metxml = WWW::MetXML->new(lang => 'ja', source => 'amedas');
    
    ### set some attributes from AUTOLOAD method
    $metxml->station('40336');
    $metxml->resolution('hourly');
    $metxml->elements([qw[airtemperature rain wind]]);
    
    my $station = $metxml->station;
    say $station->name;   # 'Tsukuba'
    
    my $dataset = $metxml->dataset(
        interval => [ qw[2013/08/17 2013/08/20] ],
    );
    
    my $temp = $dataset->item('airtemperature');
    say $temp->{Max}{'2013/08/19 13:00'};   # '33.6' (unit = Celsius temp.)
    
    my $wind = $dataset->element('wind');
    say $wind->{Speed}{'2013/08/19 13:00'}; # '3' (unit = m/s)

# DESCRIPTION

MetXML(MetBroker XML) is an open API for accessing stored weather data, by National Agriculture and Food Research Organization, of Japan.

WWW::MetXML provides object oriented interface for MetXML.

# METHODS

## $metxml = WWW::MetXML->new( %attr )

Instantiate WWW::MetXML. You may specify some attributes as hash. 

These attributes will use as query-parameters when sending request to MetXML API.

## $metxml->source( %attr )

Send request to MetXML API and Returns WWW::MetXML::Source instance. 

Arguments will append or overwrite if you specify it in argument.

## $metxml->region( %attr )

Send request to MetXML API and Returns WWW::MetXML::Region instance. 

Arguments will append or overwrite if you specify it in argument.

## $metxml->station( %attr )

Send request to MetXML API and Returns WWW::MetXML::Station instance. 

Arguments will append or overwrite if you specify it in argument.

## $metxml->dataset( %attr )

Send request to MetXML API and Returns WWW::MetXML::Dataset instance. 

Arguments will append or overwrite if you specify it in argument.

# AUTOLOAD

AUTOLOAD is implemented as attribute accessor method.

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>

# SEE ALSO

[http://agrid.diasjp.net/model/metbroker2/help/metxml.html](http://agrid.diasjp.net/model/metbroker2/help/metxml.html)
