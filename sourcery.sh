#!/bin/sh

SOURCERY=/usr/local/Cellar/sourcery/1.6.1/bin/sourcery

if [ ! -f "$SOURCERY" ]; then
    echo "$SOURCERY not executable found."
    exit 1
fi


# Script to run sourcery for the project.
$SOURCERY --config Sourcery/.sourcery.yml
