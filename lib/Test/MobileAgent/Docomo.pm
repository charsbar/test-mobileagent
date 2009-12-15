package Test::MobileAgent::Docomo;

use strict;
use warnings;
use base 'Test::MobileAgent::Base';

sub _modify_headers {
  my ($class, %headers) = @_;

  $headers{HTTP_X_DCMGUID} ||= 'DCMGUID';

  my $serial  = delete $headers{_SERIAL_NUMBER} || '';

  if ($serial) {
    my $padding = '1234567890' x 2;
    my $ua = $headers{HTTP_USER_AGENT};
    my ($main, $extra) = split / /, $ua, 2;
    if ($extra and substr($extra, 0, 1) ne '(') {
      # looks like foma
      $serial = substr("$serial$padding", 0, 15);
      my $card_id = delete $headers{_CARD_ID} || $padding;

      $extra =~ s/;ser\w{15}/;ser$serial/;
      $extra =~ s/;icc\w{20}/;icc$card_id/;
      unless ($extra =~ /;ser/) {
        $extra =~ s/(c\d+)/$1;ser${serial};icc${card_id}/;
      }
      $headers{HTTP_USER_AGENT} = "$main $extra";
    }
    else {
      $serial = substr("$serial$padding", 0, 11);

      $main =~ s|/ser\w{11}|/ser$serial|;
      unless ($main =~ m|/ser\w{11}|) {
        $main .= "/ser$serial";
      }
      $headers{HTTP_USER_AGENT} = $main;
      $headers{HTTP_USER_AGENT} .= " $extra" if $extra;
    }
  }

  return %headers;
}

# this list is borrowed from HTTP::MobileAgent's t/02_docomo.t
sub _list {q(
DoCoMo/1.0/633S/c20
DoCoMo/1.0/641P/c10
DoCoMo/1.0/641S/c10
DoCoMo/1.0/642S/c20
DoCoMo/1.0/Agent
DoCoMo/1.0/D209i
DoCoMo/1.0/D209i/c10
DoCoMo/1.0/D210i/c10
DoCoMo/1.0/D211i/c10
DoCoMo/1.0/D251i/c10
DoCoMo/1.0/D501i
DoCoMo/1.0/D501i/c5
DoCoMo/1.0/D502i
DoCoMo/1.0/D502i/c10
DoCoMo/1.0/D503i
DoCoMo/1.0/D503i/c10
DoCoMo/1.0/D503i/c5
DoCoMo/1.0/D503iS/c10
DoCoMo/1.0/D503iS/c5
DoCoMo/1.0/D504i/c10
DoCoMo/1.0/F504i/c10/TB
DoCoMo/1.0/D504i/c10/TJ
DoCoMo/1.0/D504i/c30/TD
DoCoMo/1.0/D505i/c20/TC/W20H10
DoCoMo/1.0/ER209i
DoCoMo/1.0/ER209i/c15
DoCoMo/1.0/F209i
DoCoMo/1.0/F209i/c10
DoCoMo/1.0/F210i/c10
DoCoMo/1.0/F211i/c10
DoCoMo/1.0/F212i/c10/TB
DoCoMo/1.0/F251i/c10/TB
DoCoMo/1.0/F501i
DoCoMo/1.0/F502i
DoCoMo/1.0/F502i/c10
DoCoMo/1.0/F502it
DoCoMo/1.0/F502it/c10
DoCoMo/1.0/F503i
DoCoMo/1.0/F503i/c10
DoCoMo/1.0/F503i/c32
DoCoMo/1.0/F503iS
DoCoMo/1.0/F503iS/c10
DoCoMo/1.0/F504i/c10/TB
DoCoMo/1.0/F504i/c10/TJ
DoCoMo/1.0/F661i/c10/TB
DoCoMo/1.0/F671i/c10
DoCoMo/1.0/F671iS/c10/TB
DoCoMo/1.0/GigaCode (http://gigacode.net/)
DoCoMo/1.0/KO209i
DoCoMo/1.0/KO210i
DoCoMo/1.0/KO210i/c10
DoCoMo/1.0/N209i
DoCoMo/1.0/N209i/c08
DoCoMo/1.0/N210i
DoCoMo/1.0/N210i/c10
DoCoMo/1.0/N211i/c10
DoCoMo/1.0/N501i
DoCoMo/1.0/N502i
DoCoMo/1.0/N502i/c08
DoCoMo/1.0/N502it
DoCoMo/1.0/N502it/c10
DoCoMo/1.0/N503i
DoCoMo/1.0/N503i/c10
DoCoMo/1.0/N503i/c30
DoCoMo/1.0/N503i/c5
DoCoMo/1.0/N503i/c5/serNNEBJ608187
DoCoMo/1.0/N503iS
DoCoMo/1.0/N503iS/c10
DoCoMo/1.0/N503iS/c5
DoCoMo/1.0/N504i/c10
DoCoMo/1.0/N504i/c10/TB
DoCoMo/1.0/N504i/c10/TJ
DoCoMo/1.0/N504i/c10/TJ/c0
DoCoMo/1.0/N821i
DoCoMo/1.0/N821i/c08
DoCoMo/1.0/NM502i
DoCoMo/1.0/NM502i/c10
DoCoMo/1.0/P209i
DoCoMo/1.0/P209i/c10
DoCoMo/1.0/P209is
DoCoMo/1.0/P209is (Google CHTML Proxy/1.0)
DoCoMo/1.0/P209is/c10
DoCoMo/1.0/P210i
DoCoMo/1.0/P210i/c10
DoCoMo/1.0/P211i/c10
DoCoMo/1.0/P501i
DoCoMo/1.0/P502i
DoCoMo/1.0/P502i/c10
DoCoMo/1.0/P502i/c10 (Google CHTML Proxy/1.0)
DoCoMo/1.0/P502i_mEB-PD555
DoCoMo/1.0/P503i
DoCoMo/1.0/P503i/c10
DoCoMo/1.0/P503i/c10/
DoCoMo/1.0/P503i/c10/serNMABH200331
DoCoMo/1.0/P503iS
DoCoMo/1.0/P503iS/c10
DoCoMo/1.0/P503iS/c10/serNMAUA482012
DoCoMo/1.0/P504i/c10
DoCoMo/1.0/P504i/c10/TB
DoCoMo/1.0/P751v/c100/s64/kPHS-K
DoCoMo/1.0/P821i
DoCoMo/1.0/P821i/c08
DoCoMo/1.0/PacketMeter/c10
DoCoMo/1.0/R209i
DoCoMo/1.0/R211i/c10
DoCoMo/1.0/R691i
DoCoMo/1.0/R692i/c10
DoCoMo/1.0/SH251i/c10
DoCoMo/1.0/SH505i2/c20/TB/W20H10
DoCoMo/1.0/SH712m/c10
DoCoMo/1.0/SH821i
DoCoMo/1.0/SH821i/c10
DoCoMo/1.0/SO210i/c10
DoCoMo/1.0/SO211i/c10
DoCoMo/1.0/SO502i
DoCoMo/1.0/SO502iWM/c10
DoCoMo/1.0/SO503i
DoCoMo/1.0/SO503i/c10
DoCoMo/1.0/SO503i/c10/serNSOBD506895
DoCoMo/1.0/SO503i/c10/serNSOBD597705
DoCoMo/1.0/SO503iS/c10
DoCoMo/1.0/SO504i/c10
DoCoMo/1.0/SO504i/c10/TB
DoCoMo/1.0/TEST/c10
DoCoMo/1.0/TF502i
DoCoMo/1.0/X503i/c10
DoCoMo/1.0/eggy/c300/s32/kPHS-K
DoCoMo/1.0/eggy/c300/s64/kPHS-K
DoCoMo/1.0/ex_idisplay/c10
DoCoMo/1.0/ex_ps_test00/c10
DoCoMo/1.0/iYappo
DoCoMo/1.0/p503is/c10
DoCoMo/1.0/test
DoCoMo/1.0/test/c10
DoCoMo/1.0/test/c10/TB
DoCoMo/1.1/P711m/c10
DoCoMo/2.0 D2101V(c100)
DoCoMo/2.0 MST_v_P2101V(c100)
DoCoMo/2.0 MST_v_SH2101V(c100)
DoCoMo/2.0 N2001(c10)
DoCoMo/2.0 N2001(c10;ser350200000307969;icc8981100000200188565F)
DoCoMo/2.0 N2001(c10;ser0123456789abcde;icc01234567890123456789)
DoCoMo/2.0 N2002(c100)
DoCoMo/2.0 N2051(c100;TB)
DoCoMo/2.0 P07A3(c500;TB;W24H15)
DoCoMo/2.0 P2002(c100)
DoCoMo/2.0 P2101V
DoCoMo/2.0 P2101V(c100)
DoCoMo/2.0 T2101V(c100)
DoCoMo/2.0/N502i
DoCoMo/2.0/N502it
DoCoMo/2.0/N503i
DoCoMo/3.0/N503
DoCoMo/2.0 N06A3(c500;TB;W24H16)
DoCoMo/2.0 N04A(c100;TB;W24H16)
DoCoMo/2.0 N08A(c500;TB;W24H16)
)}

1;

__END__

=head1 NAME

Test::MobileAgent::Docomo

=head1 SEE ALSO

See L<HTTP::MobileAgent>'s t/02_docomo.t, from which the data is borrowed.

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
