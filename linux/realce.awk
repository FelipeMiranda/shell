#!/bin/bash


 awk -v var="$1" '
BEGIN{
RED="\033[31m";
NORMAL="\033[39m";
}
/'$1'/{ print RED $0 }
!/'$1'/{ print NORMAL $0 }
'
