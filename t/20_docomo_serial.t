use strict;
use warnings;
use Test::More;
use Test::MobileAgent ':all';
use HTTP::MobileAgent;

{
  my $serial  = 'serialnumber000';
  my $card_id = 'cardidcardidcardid00';

  local %ENV;
  test_mobile_agent(
    'docomo.P07A',
    _serial_number => $serial,
    _card_id       => $card_id,
  );
  my $ua = HTTP::MobileAgent->new;
  is $ua->serial_number => $serial;
  is $ua->card_id       => $card_id;
}

done_testing;
