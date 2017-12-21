#!/bin/bash

PUPPET_CMD="puppetd --server=auto-gt.intranet --no-daemonize --no-usecacheonfailure -o --pluginsync --report -v"


sse $1 "$PUPPET_CMD"
