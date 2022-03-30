#!/bin/bash

lambdas=($(aws lambda list-functions | grep FunctionName | cut -d ":" -f 2 | cut -d '"' -f 2))

i=0

for lambda in "${lambdas[@]}"
do
	i=$(expr $i + 1)
    echo "$i - start $lambda"
    uri=$(aws lambda get-function --function-name $lambda | grep Location | cut -d '"' -f 4)
    name=$(echo $uri | cut -d '/' -f 6 | cut -d "?" -f 1)
    echo "$i download $name"
    wget -O $name $uri
done

echo DONE
