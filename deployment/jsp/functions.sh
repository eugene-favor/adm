#!/bin/bash

function usage()
{
cat << EOF

usage: $0 options

This script deploy JSP file on server.

OPTIONS:
   -s      Server name
   -j      jsp file
   -u      user
   -a      time example "13:00 13.03.2013"
   -h      help
   -w      where execute jsp: server , local (use with -a)
EOF
}

function deploy()
{

JSP=$1
eval $2
SERVER=$3
USER=$4
AT=$5
WHERE_EXEC=$6
SERVER_INFO=

eval "SERVER_INFO=${servers[${SERVER}]}"

if [[ ! -z ${SERVER_INFO} ]]; then

    read -p "deploy ${JSP} to ${SERVER} server?(yY/n)"

    if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
        HOST=${SERVER_INFO[0]}
        DIRECTORY=${SERVER_INFO[1]}
        EXTERNAL_PORT=${SERVER_INFO[2]}
        INTERNAL_PORT=${SERVER_INFO[3]}

        echo -n "DEPLOYING to SERVER: ${SERVER} (${HOST}:${DIRECTORY}/webapps/ROOT/${JSP})"

        ssh -t ${USER}@${HOST} mkdir -p /home/${USER}/jsp
        ssh -t ${USER}@${HOST} chmod -R 770  /home/${USER}/jsp
        scp ${JSP} ${USER}@${HOST}:/home/${USER}/jsp/
        ssh -t ${USER}@${HOST} chmod 664  /home/${USER}/jsp/${JSP}
        ssh -t ${USER}@${HOST} cp --preserve /home/${USER}/jsp/${JSP} ${DIRECTORY}/webapps/ROOT/

        if [[ ! -z ${AT} ]]; then

            echo "${AT}"

            case ${WHERE_EXEC} in
                "server")
                    execAtServer ${JSP} ${SERVER} ${HOST} ${INTERNAL_PORT} ${DIRECTORY} ${USER} "${AT}"
                    ;;
                "local")
                    execAtLocal ${JSP} ${SERVER} ${HOST} ${EXTERNAL_PORT} ${DIRECTORY} ${USER} "${AT}"
                    ;;
#                *)
#                    execAtLocal ${JSP} ${SERVER} ${HOST} ${EXTERNAL_PORT} ${DIRECTORY} ${USER} "${AT}"
#                    ;;
            esac


        fi
    else
        echo -n "Abort deploy ${JSP} to ${SERVER} server"
    fi


else
    echo -n "Server ${SERVER} is undefined";
fi

}

execAtLocal()
{

JSP=$1
SERVER=$2
HOST=$3
PORT=$4
DIRECTORY=$5
USER=$6
AT=$7

read -p "execute at ${AT}?(yY/n)"

if [[ "${REPLY}" == "y" || "${REPLY}" == "Y" ]]; then

    URL=$(getUrl ${HOST} ${PORT} ${JSP})

    echo -n "EXECUTION FROM LOCALHOST FOR server ${SERVER} at ${AT} (${URL})"
    getExecCommand ${USER} ${JSP} ${SERVER} ${URL}
    mv ${JSP}.execute.on.${SERVER} /home/${USER}/jsp/
    at ${AT} -f /home/${USER}/jsp/${JSP}.execute.on.${SERVER}
    atq
else
    echo "Abort execution"
fi

}

getUrl()
{
    HOST=$1
    PORT=$2
    JSP=$3

    echo "http://${HOST}:${PORT}/${JSP}"
}

getExecCommand()
{
    USER=$1
    JSP=$2
    SERVER=$3
    URL=$4

    echo "wget -O /home/${USER}/jsp/${JSP}.output.on.${SERVER} -o /home/${USER}/jsp/${JSP}.output.ERROR.on.${SERVER} ${URL}" > ${JSP}.execute.on.${SERVER}
}

execAtServer()
{

    JSP=$1
    SERVER=$2
    HOST=$3
    PORT=$4
    DIRECTORY=$5
    USER=$6
    AT=$7

    read -p "execute at ${AT}?(yY/n)"

if [[ "${REPLY}" == "y" || "${REPLY}" == "Y" ]]; then

    URL=$(getUrl ${HOST} ${PORT} ${JSP})

    echo -n "EXECUTION ON SERVER: ${SERVER} at ${AT} (${URL})"

    ssh -t ${USER}@${HOST} rm /home/${USER}/jsp/${JSP}.execute.on.${SERVER}
    ssh -t ${USER}@${HOST} rm /home/${USER}/jsp/${JSP}.execute.output.on.${SERVER}
    getExecCommand ${USER} ${JSP} ${SERVER} ${URL}
    scp ${JSP}.execute.on.${SERVER} ${USER}@${HOST}:/home/${USER}/jsp
    rm ${JSP}.execute.on.${SERVER}
    ssh -t ${USER}@${HOST} at ${AT} -f /home/${USER}/jsp/${JSP}.execute.on.${SERVER}
    ssh -t ${USER}@${HOST} atq
else
    echo "Abort execution"
fi

}
