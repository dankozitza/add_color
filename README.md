[36m[32mUsage: perl add_color.pl [option] [filename][0m[0m

[36m[32m ----- add_color:[0m[0m

[36m takes a stream or a filename as input and outputs with ansi color[0m
[36m codes added to individual lines of text.[0m

[36m[32m example use:[0m[0m

[36m    $ ./add_color.pl /text/file/with/custom_tags.txt[0m
[36m    $ ping localhost | ./add_color.pl[0m
[36m    $ perl add_color.pl -h | less -r[0m

[36m[32m params:[0m[0m

[36m    -h --help   print this message[0m
[36m    <filename>  file who's contents will be output with color.[0m

[36m[32m notes:[0m[0m

[36m    usually i use this to highlight certain messages in logs.[0m
[36m    By piping the output of this script into less -r you can get[0m
[36m    a much nicer ui for analyzing logs. only use this if you are[0m
[36m    giving a file name as input[0m

[36m    You can configure this script by modifying it manually. The [0m
[36m    %modifications hash is used to set regular expressions.[0m
[36m    when a match is found any line of input containing the [0m
[36m    match will be wrapped in the appropriate ansi escape code.[0m


