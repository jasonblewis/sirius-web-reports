package ReportUtils;

require Exporter;

@ISA = qw(Exporter);
@EXPORT_OK = qw(ltrim rtrim trim);

sub ltrim { my $s = shift; $s =~ s/^\s+//;       return $s };
sub rtrim { my $s = shift; $s =~ s/\s+$//;       return $s };
sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

1;
