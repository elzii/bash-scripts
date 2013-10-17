#!/bin/bash

perl -e 'for($i=0;;$i++){
    print pack("n", ((($i*($i>>8|$i>>9)&46&$i>>8))^($i&$i>>13|$i>>6))); 

 | ./play -c 2 -b 8 -e unsigned -t raw -r 48k -}''}'
