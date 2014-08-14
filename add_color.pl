#!/usr/bin/perl

# any key found in this hash must also be a key in the %colors hash
# Each key corresponds to an array of tags. Any time a tag is found
# in a line that line will be wrapped in the appropriate color code.
#
my %modifications = (
   cyan      => [ # color code
      'POST', # regular expression
      'upload',
      ' \/tadcmd\.cgi.*tadcmd=\w',
   ],
   red_bg => [
      'CONNECT',
   ],
   black => [
      'CONNECT',
   ],
   red => [
      'HTTP\/1\.1\" 404',
   ],
   yellow => [
      'HTTP\/1\.1\" 304',
   ],
   #blue_bg => [
   #   'HTTP\/1\.1\" 200',
   #],
   blue => [
      'GET \/\w*\.pl',
   ],
   green => [
      'GET \/\s',
   ],
);

my %colors = (
   black          => '\x1b[30m&\x1b[0m',
   white          => '\x1b[37m&\x1b[0m',
   cyan           => '\x1b[36m&\x1b[0m',
   green          => '\x1b[32m&\x1b[0m',
   red            => '\x1b[31m&\x1b[0m',
   yellow         => '\x1b[33m&\x1b[0m',
   magenta        => '\x1b[35m&\x1b[0m',
   blue           => '\x1b[34m&\x1b[0m',
   cyan_bg        => '\x1b[46m&\x1b[0m',
   blue_bg        => '\x1b[44m&\x1b[0m',
   purple_bg      => '\x1b[45m&\x1b[0m',
   green_bg       => '\x1b[42m&\x1b[0m',
   yellow_bg      => '\x1b[43m&\x1b[0m',
   red_bg         => '\x1b[41m&\x1b[0m',
   white_bg       => '\x1b[47m&\x1b[0m',
   bold           => '\x1b[1m&\x1b[0m',
);

my $cnt = 0;
foreach my $arg (@ARGV) {
   $cnt++;
   if ($arg eq "-t" || $arg eq "--tag") {
      my $found = 0;
      foreach my $color (keys(%colors)) {
         if ($color eq $ARGV[$cnt]) {
            $found = 1;
            last;
         }
      }
      next if (!$found);

      push(@{$modifications{$ARGV[$cnt]}}, $ARGV[$cnt+1]);
   }
   if ($arg eq "-c" || $arg eq "--clear") {
      %modifications = ();
   }
}

my $cmd;

if ($ARGV[0] eq "-h" || $ARGV[0] eq "--help") {
   %modifications = ();
   $modifications{cyan} = [".*"];
   $modifications{green} = [":"];

   if ($0 =~ /.*\/(.+)$/) {
      $prog = $1;
   }

   my $help_msg = "Usage: perl $prog [option] [filename]\n\n"
      . " ----- $prog:\n\n"
      . " takes a stream or a filename as input and outputs with ansi color\n"
      . " codes added to individual lines of text.\n\n"
      . " example use:\n\n"
      . "    \$ ./$prog /text/file/with/custom_tags.txt\n"
      . "    \$ ping localhost | ./$prog\n"
      . "    \$ perl $prog -h | less -r\n"
      . "    \$ ./$prog nginx_access.log\n\n"
      . " params:\n\n"
      . "    -h --help   print this message\n\n"
      . "    -c --clear  clear the built in color settings\n\n"
      . "    -t --tag <color> <regex>\n"
      . "                add custom color tags. Any line that matches regex\n"
      . "                will be colored color\n\n"
      . "    <filename>  file who's contents will be output with color.\n\n"
      . " notes:\n\n"
      . "    usually i use this to highlight certain messages in logs.\n"
      . "    By piping the output of this script into less -r you can get\n"
      . "    a much nicer ui for analyzing logs. only do this if you are\n"
      . "    giving a file name as input\n\n"
      . "    You can configure this script by modifying it manually. The \n"
      . "    \%modifications hash is used to set regular expressions.\n"
      . "    when a match is found any line of input containing the \n"
      . "    match will be wrapped in the appropriate ansi escape code.\n\n";
      
   $cmd = "echo \"$help_msg\" | sed ";

}
else {
   $cmd = 'cat ' . $ARGV[0] . ' | sed ';
}

foreach my $mod (keys %modifications) {
   foreach my $tag (@{$modifications{$mod}}) {
      $cmd .= '-e "s/.*\b' . $tag . '.*/' . $colors{$mod} . '/" ';
   }
}

system($cmd);

