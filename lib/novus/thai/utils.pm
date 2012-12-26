package novus::thai::utils;

use 5.014002;
use strict;
use warnings;
use Config::JFDI;
use Cwd;
use DateTime::Format::Strptime;
use Try::Tiny;
require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use novus::thai::utils ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

sub get_config {
    my ($self) = @_;
    
    my $dir = getcwd;
    
    # called from external by 'use'
    if ($dir !~ /novus-thai-utils$/) {
        $dir .= "/../novus-thai-utils";
    } 
    
    my $config = Config::JFDI->new(name => "novus-thai", path => "$dir/etc");
    my $config_hash = $config->get;
    
    return $config_hash;
}

sub string_to_timestamp {
    my ($self, $str_date) = @_;
    
    my $parser_no_tz = new DateTime::Format::Strptime(pattern     => '%a, %d %B %Y %H:%M:%S',
                                                    time_zone   => 'Asia/Bangkok',
#                                                    on_error    => 'croak',
                                                    );
    my $parser_tz_name = new DateTime::Format::Strptime(pattern     => '%a, %d %B %Y %H:%M:%S %Z', );
                                                
    my $parser_tz_num = new DateTime::Format::Strptime(pattern     => '%a, %d %B %Y %H:%M:%S %z', );
                                                
    my $last_timestamp;
    
    if (!$last_timestamp) { # try time zone name
        try {
            $last_timestamp = $parser_tz_name->parse_datetime($str_date);
        }
    }
    
    if (!$last_timestamp) { # try time zone number
        try {
            $last_timestamp = $parser_tz_num->parse_datetime($str_date);
        }
    }
    
    if (!$last_timestamp) { # try no time zone
        try {
            $last_timestamp = $parser_no_tz->parse_datetime($str_date);
        }
    }
    
    if ($last_timestamp) {
        return $last_timestamp->epoch;
    } else {
        return time;
    }
    
    
}

sub trim {
    my($self, $strin) = @_;
    $strin =~ s/^\s+//;
    $strin =~ s/\s+$//;

    return $strin;
}

sub clean_context {
    my($self, $content) = @_;
    
    # lower case
    $content = lc($content);
    
    # Single space
    $content =~ s/\s+/ /g;
    
    $content = $self->trim($content);
    
    return $content;
}

1;
__END__

