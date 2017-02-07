#!/bin/bash

source config.sh

function create_account()
{

    eval $1
    USERNAME=$2
    SERVER=$3

    eval "SERVER_INFO=${servers[${SERVER}]}"

    if [[ ! -z ${SERVER_INFO} ]]; then
        SERVER_IP=${SERVER_INFO[0]}

        read -p "create account ${USERNAME} on server ${SERVER} (${SERVER_IP}) server?(yY/n)"

        if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
            echo "Account ${USERNAME} creation on server ${SERVER}"
            scp create_account_bootstrap.sh ${USERNAME}.pub ${ADMIN_LOGIN}@${SERVER_IP}:/home/${ADMIN_LOGIN}/
            ssh -t ${ADMIN_LOGIN}@${SERVER_IP} sudo /home/${ADMIN_LOGIN}/create_account_bootstrap.sh ${USERNAME}
            ssh -t ${ADMIN_LOGIN}@${SERVER_IP} rm /home/${ADMIN_LOGIN}/create_account_bootstrap.sh
        else
            echo -n "Abort ${USERNAME} creation on server ${SERVER}"
        fi
    else
        echo -n "Server ${SERVER} is undefined";
    fi
}

function usage()
{
cat << EOF

usage: $0 options

This script deploy JSP file on server.

OPTIONS:
   -s      Server name
   -u      user
   -h      help
EOF
}

if [[ $# -eq 0 ]] ; then
    usage
    exit 0
fi

SERVER=
USERNAME=

while getopts "s:u:h:" OPTION
do
     case $OPTION in
         s)
             SERVER=$OPTARG
             ;;
         u)
             USERNAME=$OPTARG
             ;;
         h)
             usage
             exit 0
             ;;
         *)
             usage
             exit 1
             ;;
     esac
done

if [[ -z ${SERVER} ]]; then
    read -p "add username ${USERNAME} to all servers?(yY/n)"

    if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
      for s in "${!servers[@]}";
          do
              create_account "$(declare -p servers)" ${USERNAME} ${s} ${USERNAME}.pub
          done
    else
        echo -e "\nAbort account creation \n"
        exit 0
    fi
else

    create_account "$(declare -p servers)" ${USERNAME} ${SERVER} ${USERNAME}.pub

fi