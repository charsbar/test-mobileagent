package Test::MobileAgent::Docomo;

use strict;
use warnings;
use base 'Test::MobileAgent::Base';

sub _modify_headers {
  my ($class, %headers) = @_;

  if (exists $headers{_USER_ID}) {
    $headers{HTTP_X_DCMGUID} = delete $headers{_USER_ID};
  }

  # should be able to be empty to test guid-related behavior
  $headers{HTTP_X_DCMGUID} = 'DCMGUID' unless defined $headers{HTTP_X_DCMGUID};

  my $serial = delete $headers{_SERIAL_NUMBER} || '';

  if ($serial) {
    my $padding = '1234567890' x 2;
    my $ua = $headers{HTTP_USER_AGENT};
    my ($main, $extra) = split / /, $ua, 2;
    if ($extra and substr($extra, 0, 1) ne '(') {
      # looks like foma
      $serial = substr("$serial$padding", 0, 15);
      my $card_id = delete $headers{_CARD_ID} || '';
      $card_id = substr("$card_id$padding;", 0, 20);

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
        $main .= "/" unless $main =~ m|^[^/]+/[^/}+/[^/]+/.+|;
        $main .= "/ser$serial";
      }
      $headers{HTTP_USER_AGENT} = $main;
      $headers{HTTP_USER_AGENT} .= " $extra" if $extra;
    }
  }

  return %headers;
}

# this list is borrowed from HTTP::MobileAgent's t/02_docomo.t
# last updated: __DATE__
sub _list {q{
__LIST__
}}

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
