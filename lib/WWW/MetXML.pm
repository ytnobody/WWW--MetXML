package WWW::MetXML;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";
our $AUTOLOAD;

use WWW::MetXML::SourceList;
use WWW::MetXML::RegionList;
use WWW::MetXML::StationList;
use WWW::MetXML::Dataset;

sub AUTOLOAD {
    my ($self, $var) = @_;
    my $attr = do { my @part = split '::', $AUTOLOAD; pop @part };
    if ($attr =~ /^[a-z]+$/) {
        $self->{$attr} = $var if defined $var;
        return $self->{$attr};
    }
}

sub new {
    my ($class, %opts) = @_;
    bless {%opts}, $class;
}

sub source {
    my ($self, %opts) = @_;
    WWW::MetXML::SourceList->new(%$self, %opts);
}

sub region {
    my ($self, %opts) = @_;
    WWW::MetXML::RegionList->new(%$self, %opts);
}

sub station {
    my ($self, %opts) = @_;
    WWW::MetXML::StationList->new(%$self, %opts);
}

sub dataset {
    my ($self, %opts) = @_;
    WWW::MetXML::Dataset->new(%$self, %opts);
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::MetXML - Perl Interface of MetXML(MetBroker XML)

=head1 SYNOPSIS

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

=head1 DESCRIPTION

MetXML(MetBroker XML) is an open API for accessing stored weather data, by National Agriculture and Food Research Organization, of Japan.

WWW::MetXML provides object oriented interface for MetXML.

=head1 METHODS

=head2 $metxml = WWW::MetXML->new( %attr )

Instantiate WWW::MetXML. You may specify some attributes as hash. 

These attributes will use as query-parameters when sending request to MetXML API.

=head2 $metxml->source( %attr )

Send request to MetXML API and Returns WWW::MetXML::Source instance. 

Arguments will append or overwrite if you specify it in argument.

=head2 $metxml->region( %attr )

Send request to MetXML API and Returns WWW::MetXML::Region instance. 

Arguments will append or overwrite if you specify it in argument.

=head2 $metxml->station( %attr )

Send request to MetXML API and Returns WWW::MetXML::Station instance. 

Arguments will append or overwrite if you specify it in argument.

=head2 $metxml->dataset( %attr )

Send request to MetXML API and Returns WWW::MetXML::Dataset instance. 

Arguments will append or overwrite if you specify it in argument.

=head1 AUTOLOAD

AUTOLOAD is implemented as attribute accessor method.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

L<http://agrid.diasjp.net/model/metbroker2/help/metxml.html>

=cut

