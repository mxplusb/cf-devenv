#!/bin/bash

mkdir demos

for i in `curl -s https://api.github.com/orgs/cloudfoundry-samples/repos?per_page=200 | grep html_url | awk 'NR%2 == 0' | cut -d ':'  -f 2-3 | tr -d '",'`
do
    git clone $i.git demos/$i
done