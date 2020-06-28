#!/bin/bash

# Need one and only one parameter
if [ $# -ne 1 ]; then
  echo "Usage: $0 <new branch name>"
  echo "No spaces or such funny characters are allowed."
  exit 1
fi

# Make sure we're inside a git directory
git status >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "error: run this script from inside a git repository"
  exit 1
fi

BRANCH=`git rev-parse --abbrev-ref HEAD`

isEdition=`expr "$BRANCH" : 'editions'`

if [ $isEdition -ne 8 ]; then
  echo "WARNING - you're starting a new branch from $BRANCH"
  echo "That doesn't look like an editions/x.x branch!"
  read -p "Hit Ctrl-C to cancel, or RETURN to continue" choice
fi

git checkout -b $1
git checkout $BRANCH

echo Added branch for "$1".
echo "You're now back on the '$BRANCH' branch."

