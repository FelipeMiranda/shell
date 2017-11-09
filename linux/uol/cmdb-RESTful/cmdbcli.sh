#!/bin/bash

#auth
#user="svcacc_sm_api_ecom"
#password="7r&wRumA"

#auth
user="svcacc_check_email"
password="1zAeRXw5"

#bin
CURL=$(which curl)
JQ=$(which jq)
XARGS=$(which xargs)

#api
API_SM="http://system.app-server.sm.intranet:13500/SM/9/rest"

usage () {
    script_name=`basename $0`
    echo
    printf "  How To\n Use: $script_name\n"
    printf "    -p <pool-name> Search pool output: ci;owner;status \n"
    printf "    -s <ci> Search CI with output ci;owner;status \n"
    printf "    -E <ci> Extended search in CI with regexp \n"
    printf "    -r <ci> Relationships\n"
    printf "    -l <ci> List All Email Servers \n"
    printf "    -h <help> \n"
    echo
    exit 1;
}

ci_status(){
    echo "Configuration Item"
        $CURL -s -m 10 -u "$user:$password" -X GET  \
        "http://system.app-server.sm.intranet:13500/SM/9/rest/uol_ruby_configuration_item?query=logical.name="%22$CI_STATUS%22"&view=expand" | \
        $JQ '.content[0].ConfigurationItem.ConfigurationItem, .content[0].ConfigurationItem.assignment, .content[0].ConfigurationItem.istatus' 2> /dev/null | \
        $XARGS echo | sed 's/ /;/g'
}


ci_regexp(){
    echo "Configuration Item"
        $CURL -s -m 10 -u "$user:$password" -X GET "http://system.app-server.sm.intranet:13500/SM/9/rest/uol_ruby_configuration_item?query=logical.name+like+"%22$CI_REGEXP%22"" | $JQ '.content[] .ConfigurationItem .ConfigurationItem' 2> /dev/null
}

relationship(){
    echo "Upstream Configuration Item"
        $CURL -s -m 10 -u "$user:$password" -X GET  \
        http://system.app-server.sm.intranet:13500/SM/9/rest/uol_ruby_configuration_item_relationship?query=logical.name="%22$RELATED%22" | \
        $JQ '.content[] .ConfigurationItemRelationship.ParentConfigurationItem' 2> /dev/null

    echo "Downstream Asset" 
        $CURL -s -m 10 -u "$user:$password" -X GET  \
        http://system.app-server.sm.intranet:13500/SM/9/rest/uol_ruby_configuration_item_relationship?query=ParentConfigurationItem="%22$RELATED%22" | \
        $JQ '.content[] .ConfigurationItemRelationship.ConfigurationItem' 2> /dev/null
}

pool_servers_list(){
        $CURL -s -m 10 -u "$user:$password" -X GET  \
        http://system.app-server.sm.intranet:13500/SM/9/rest/uol_ruby_configuration_item_relationship?query=ParentConfigurationItem="\"pool-$POOL_NAME\"" | \
        $JQ '.content[] .ConfigurationItemRelationship.ConfigurationItem' 2> /dev/null | tr "\"" " " |  tee $HOME/servers/pool-$POOL_NAME 
}

list_all_servers(){
 		echo "Listing All Email Servers"
        $CURL -s -m 10 -u "$user:$password" -X GET http://system.app-server.sm.intranet:13500/SM/9/rest/uol_ruby_configuration_item_relationship?query=type=servidor 2> /dev/null  
			#| $JQ .content[] 
        #http://system.app-server.sm.intranet:13500/SM/9/rest/uol_ruby_configuration_item_relationship?query=\"type#\"pool\" and not istatus=\"aposentado\" and not istatus=\"desativado\" and assignment#\"email\"\" 2> /dev/null 
#	$JQ '.content[] .ConfigurationItemRelationship.ConfigurationItem' 2> /dev/null
}

  while getopts "hr:s:E:l:p:help" opt; do
    case ${opt} in
      s) CI_STATUS="${OPTARG}" && ci_status ;;
      E) CI_REGEXP="${OPTARG}" && ci_regexp ;;
      r) RELATED="${OPTARG}" && relationship ;;
      p) POOL_NAME="${2}" && echo Creating $HOME/servers/pool-${2} ... && pool_servers_list ;;
      l) list_all_servers ;;
      *) usage ;;
    esac
  done

