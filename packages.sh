#!/bin/bash
echo "Setting up the development environment. This will take awhile."

echo "Downloading Linuxbrew."
git clone https://github.com/Linuxbrew/brew.git ~/.linuxbrew
cat <<- LBEOF > ~/.bashrc
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
LBEOF
PATH="$HOME/.linuxbrew/bin:$PATH"

# install the non-java needful.
programs=(pcre openssl curl svn git gcc python go)
for i in ${programs[@]}
do
    brew install -v $i $(brew options $i | grep "\-\-with\-")
done

# set the user paths.
cat <<- UPATHEOF > ~/.bashrc
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
UPATHEOF
