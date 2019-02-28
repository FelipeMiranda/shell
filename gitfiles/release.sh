#!/bin/bash

feature=$(git symbolic-ref --short HEAD | sed "s/release/feature/")
release=$(git symbolic-ref --short HEAD | sed "s/feature/release/")
remote_release="$(git for-each-ref --format='%(upstream:short)' refs/heads/$release)"

if [ $(git symbolic-ref --short HEAD) == $release ]; then
    echo "Releases criadas apenas apartir de Features"
    exit -1
fi

echo -en "$yellow Release: $release $normal \n"
echo -en "$yellow Feature: $feature $normal \n"

if [ $remote_release ]; then
    echo -en "$red ----- delete remote: $release $normal\n"
    git push origin :$release
fi

if [ $(git rev-parse --quiet --verify $release) ]; then
    echo -en "$red ----- delete local: $release $normal \n"
    git branch -D $release
fi

echo -en "$green ----- create release $normal \n"
git checkout -b $release
echo -en "$green ----- upstream release $normal \n"
git push --set-upstream origin $release
echo -en "$green ----- checkout feature $normal \n"
git checkout $feature
