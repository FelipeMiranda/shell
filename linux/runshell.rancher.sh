#!/bin/bash


docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.11 http://192.168.15.25:8080/v1/scripts/4C7A9272D22FE92385D5:1514678400000:lf7H9ZqKx3peVz2jHhtEIB3oA
