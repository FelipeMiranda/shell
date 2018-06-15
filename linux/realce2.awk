#!/bin/bash


 awk -v var="$1" '
BEGIN{
RED="\033[31m";
NORMAL="\033[39m";
}
/'$var'/{ print RED $0 }
!/'$var'/{ print NORMAL $0 }
'
