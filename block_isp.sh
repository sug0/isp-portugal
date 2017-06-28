#!/bin/bash

if [[ ! -d PortugalWebBlocking ]]
then
    git clone https://github.com/ToFran/PortugalWebBlocking.git &> /dev/null
    if [[ $? -ne 0 ]]
    then
        echo PortugalWebBlocking repository not found 1>&2
        exit 1
    fi
else
    cd PortugalWebBlocking/
    git pull origin master &> /dev/null
    cd ..
fi

for domain in `jq -r '.[] | keys[]' PortugalWebBlocking/blockList.json`
do
    ip=$(dig +short $domain)
    if [[ $ip  ]]
    then
        printf "%s %s.unblocked.lol\n" $(echo $ip | cut -f1 -d' ') $(echo $domain | sed s/\\./5\-/g)
    fi
done
