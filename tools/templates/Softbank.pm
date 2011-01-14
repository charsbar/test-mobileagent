package Test::MobileAgent::Softbank;

use strict;
use warnings;
use base 'Test::MobileAgent::Base';

sub _modify_headers {
  my ($class, %headers) = @_;

  if (exists $headers{_USER_ID}) {
    $headers{HTTP_X_JPHONE_UID} = delete $headers{_USER_ID};
  }

  my $serial = delete $headers{_SERIAL_NUMBER} || '';

  if ($serial) {
    my $ua = $headers{HTTP_USER_AGENT};
    my ($main, $extra) = split / /, $ua, 2;
    if ($ua =~ /^(?:Vodafone|SoftBank)/) {
      my ($name, $version, $model, $_maker, $sn) = split '/', $main;
      $main = join '/', $name, $version, $model, $_maker, "SN$serial";
    }
    elsif ($extra and $ua =~ /^J\-PHONE/) {
      my ($name, $version, $model, $sn) = split '/', $main;
      $main = join '/', $name, $version, $model, "SN$serial";
    }
    $headers{HTTP_USER_AGENT} = $main;
    $headers{HTTP_USER_AGENT} .= " $extra" if $extra;
  }

  return %headers;
}

# this list is borrowed from HTTP::MobileAgent's t/10_softbank.t
# last updated: __DATE__
sub _list {q{
__LIST__
}}

1;

__END__

=head1 NAME

Test::MobileAgent::Softbank

=head1 SEE ALSO

See L<HTTP::MobileAgent>'s t/10_softbank.t, from which the data is borrowed.

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
