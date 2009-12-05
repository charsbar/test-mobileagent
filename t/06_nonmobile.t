use strict;
use warnings;
use Test::More;
use Test::MobileAgent ':all';
use HTTP::MobileAgent;

for (test_mobile_agent_list('nonmobile')) {
    local %ENV;
    test_mobile_agent($_);
    my $agent = HTTP::MobileAgent->new;
    isa_ok $agent, 'HTTP::MobileAgent::NonMobile';
    ok ! $agent->is_docomo;
    ok ! $agent->is_j_phone;
    ok ! $agent->is_ezweb;
    ok $agent->is_non_mobile;
    ok $agent->model eq '';
    ok $agent->device_id eq '';
    ok $agent->carrier eq 'N';
    ok $agent->carrier_longname eq 'NonMobile';
    ok $agent->xhtml_compliant;
}

done_testing;
