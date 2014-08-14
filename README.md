Usage: perl add_color.pl [option] [filename]

 ----- add_color:

 takes a stream or a filename as input and outputs with ansi color
 codes added to individual lines of text.

 example use:

    $ ./add_color.pl /text/file/with/custom_tags.txt
    $ ping localhost | ./add_color.pl
    $ perl add_color.pl -h | less -r
    $ ./add_color.pl nginx_access.log

 params:

    -h --help   print this message

    -c --clear  clear the built in color settings

    -t --tag <color> <regex>
                add custom color tags. Any line that matches regex
                will be colored color

    <filename>  file who's contents will be output with color.

 notes:

    usually i use this to highlight certain messages in logs.
    By piping the output of this script into less -r you can get
    a much nicer ui for analyzing logs. only do this if you are
    giving a file name as input

    You can configure this script by modifying it manually. The 
    %modifications hash is used to set regular expressions.
    when a match is found any line of input containing the 
    match will be wrapped in the appropriate ansi escape code.

