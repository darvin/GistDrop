#!/bin/sh
{
if [ -a ~/.ssh.original ]; then
    echo "restoring"
    rm ~/.ssh
    mv ~/.ssh.original ~/.ssh

    exit 0
fi
}

echo "nothing to restore"

