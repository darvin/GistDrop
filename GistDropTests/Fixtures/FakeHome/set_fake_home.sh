#!/bin/sh
{
if [ -a ~/.ssh.original ]; then
    echo ".ssh already faked!"
    exit 0
fi
}

mv ~/.ssh ~/.ssh.original
ln -s `pwd`/dot_ssh ~/.ssh
