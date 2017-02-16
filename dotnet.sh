#!/bin/bash

# get the Microsoft repo.
echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
apt-get update

# yay for issues:https://github.com/dotnet/core/issues/502
all_dotnet=()
for i in $(apt-cache search dotnet-dev-1.0.0-preview2 | awk '{print $1}') 
    do dotnet+=(`echo $i | rev`)
done

IFS=$'\n'
updated_dotnet=($(sort <<<"${dotnet[*]}"))
needed_dotnet=${updated_dotnet[-1]}
unset $IFS

apt-get install -y `echo $needed_dotnet | rev`