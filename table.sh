#!/bin/bash

echo "table.sh < {input-file-name} > {output-file-name}"

while read line; do
    echo \<tr\>
    for item in $line; do
        echo \<td\>$item\<\/td\>
    done
    echo \<\/tr\>
done
