use strict;
use warnings;
use Test::More;
use Test::MobileAgent ':all';
use HTTP::MobileAgent;

my @Tests = (
    # ua, method_hash
    [ "Mozilla/3.0(DDIPOCKET;JRC/AH-J3001V,AH-J3002V/1.0/0100/c50)CNF/2.0",
      name => 'DDIPOCKET', vendor => 'JRC', model => 'AH-J3001V,AH-J3002V',
      model_version => '1.0', browser_version => '0100', cache_size => 50 ],
);

for (@Tests) {
    my($ua, %data) = @$_;

    local %ENV;
    test_mobile_agent($ua);
    my $agent = HTTP::MobileAgent->new;
    isa_ok $agent, 'HTTP::MobileAgent';
    isa_ok $agent, 'HTTP::MobileAgent::AirHPhone';
    ok $agent->is_airh_phone;

    for my $key (keys %data) {
        is $agent->$key(), $data{$key}, "$key is $data{$key}";
    }
}

for (test_mobile_agent_list('airh')) {
    local %ENV;
    test_mobile_agent($_);
    my $agent = HTTP::MobileAgent->new;
    isa_ok $agent, 'HTTP::MobileAgent', "$_";
    ok $agent->is_airh_phone;
}

done_testing;
