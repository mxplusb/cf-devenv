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
programs=(pcre openssl curl svn git gcc python python3 go)
for i in ${programs[@]}
do
    brew install -v $i $(brew options $i | grep "\-\-with\-")
done

# set the user paths.
cat <<- UPATHEOF > ~/.bashrc
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export GOPATH="$HOME/go"
export FINDBUGS_HOME=/usr/local/Cellar/findbugs/3.0.1/libexec
GROOVY_HOME=/home/linuxbrew/.linuxbrew/opt/groovy/libexec
UPATHEOF

echo "Installing various useful go tools."
go get -v golang.org/x/tools
go get -v github.com/golang/dep/...
go get -v github.com/golang/lint/golint
go get -v github.com/derekparker/delve/cmd/dlv

echo "Installing Oracle's Java and supporting tools."
brew cask install -v java
brew cask install -v yourkit-java-profiler
brew tap homebrew/dupes

# install things that needed java.
java_programs=(maven jetty findbugs ant gradle groovy)
for i in ${java_programs[@]}:
do
    brew install $i $(brew options $i | grep "\-\-with\-")
done
