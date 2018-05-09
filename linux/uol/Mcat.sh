#!/bin/bash


if [ ! -z $1 ]; then
cat /M.log | grep -i $1
else
echo -en "Usage $0 <filtro qualquer>\n"
fi
