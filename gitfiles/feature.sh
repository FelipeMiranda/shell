#!/bin/bash

feature="feature/$1"
remote_feature="$(git for-each-ref --format='%(upstream:short)' refs/heads/$feature)"

if [ "feature/" == $feature ]; then
    echo "Informar o nome da feature"
    exit -1
fi

echo "Feature: $feature"

if [ $(git rev-parse --quiet --verify $feature) ]; then
    echo "----- $feature ja existe"
    git checkout $feature
    exit -1
fi

echo "----- checkout stable"
git checkout stable
echo "----- git pull stable"
git pull
echo "----- criando feature"
git checkout -b $feature
echo "----- upstream new feature"
git push --set-upstream origin $feature
