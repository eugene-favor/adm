#!/bin/bash

source config.sh
source functions.sh

SERVER=
JSP=
USER=
AT=
WHERE_EXEC=

while getopts "s:j:u:a:h:w:?" OPTION
do
     case $OPTION in
         s)
             SERVER=$OPTARG
             ;;
         j)
             JSP=$OPTARG
             ;;

         u)
             USER=$OPTARG
             ;;
         w)
             WHERE_EXEC=$OPTARG
             ;;

         a)
            AT=$OPTARG

            #time example "13:00 13.03.2013"
            if [[ ! "$AT" =~ ^[0-9][0-9]:[0-9][0-9]\ [0-9][0-9]\.[0-9][0-9]\.20[1-9][0-9]$ ]]; then

                echo "date format ERROR"
                echo "correct example time example \"13:00 13.03.2013\""
                exit 1

            fi

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

if [[ -z ${USER} ]]; then
    echo -n "USER not defined"

	usage

	exit 1
fi

if [[ -z ${JSP} ]]; then
    echo -n "JSP file not defined"

	usage

	exit 1
fi

if [[ -z ${SERVER} ]]; then

    read -p "deploy ${JSP} to all servers?(yY/n)"

    if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
      for s in "${!servers[@]}";
          do
              deploy ${JSP} "$(declare -p servers)" ${s} ${USER} "${AT}" ${WHERE_EXEC}
          done
    else
        echo -e "\nAbort deploy ${JSP}\n"
        exit 0
    fi

else

    echo "WHERE_EXEC ${WHERE_EXEC} AT ${AT}"

    deploy ${JSP} "$(declare -p servers)" ${SERVER} ${USER} "${AT}"  ${WHERE_EXEC}

fi

exit 0