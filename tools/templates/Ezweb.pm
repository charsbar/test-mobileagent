package Test::MobileAgent::Ezweb;

use strict;
use warnings;
use base 'Test::MobileAgent::Base';

sub _modify_headers {
  my ($class, %headers) = @_;

  if (exists $headers{_USER_ID}) {
    $headers{HTTP_X_UP_SUBNO} = delete $headers{_USER_ID};
  }
  return %headers;
}

# this list is borrowed from HTTP::MobileAgent's t/04_ezweb.t
# last updated: __DATE__
sub _list {q{
__LIST__
}}

1;

__END__

=head1 NAME

Test::MobileAgent::Ezweb

=head1 SEE ALSO

See L<HTTP::MobileAgent>'s t/04_ezweb.t, from which the data is borrowed.

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
