package Text::Markup::Bbcode;

use 5.8.1;
use strict;
use File::BOM qw(open_bom);
use Parse::BBCode;

our $VERSION = '0.21';

sub parser {
    my ($file, $encoding, $opts) = @_;
    my $parse = Parse::BBCode->new;
    open_bom my $fh, $file, ":encoding($encoding)";
    local $/;
    my $html = $parse->render(<$fh>);
    return unless $html =~ /\S/;
    utf8::encode($html);
    return qq{<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
$html
</body>
</html>
};

}

1;
__END__

=head1 Name

Text::Markup::Bbcode - BBcode parser for Text::Markup

=head1 Synopsis

  my $html = Text::Markup->new->parse(file => 'file.bbcode');

=head1 Description

This is the L<BBcode|http://www.bbcode.org/> parser for L<Text::Markup>. It
reads in the file (relying on a
L<BOM|http://www.unicode.org/unicode/faq/utf_bom.html#BOM>), hands it off to
L<Text::Markdown> for parsing, and then returns the generated HTML as an
encoded UTF-8 string with an C<http-equiv="Content-Type"> element identifying
the encoding as UTF-8.

It recognizes files with the following extensions as Markdown:

=over

=item F<.bb>

=item F<.bbcode>

=back

=head1 Author

Lucas Kanashiro <kanashiro.duarte@gmail.com>

=head1 Copyright and License

Copyright (c) 2011-2014 Lucas Kanashiro. Some Rights Reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut