#!/bin/sh

pidCommand="ps -aux | grep \"\${appDir}/bin/tomcat/bin/bootstrap.jar\" | grep -v \"grep\" | awk '{print \$2}'"


pid=$(eval ${pidCommand})

if [ ! -z $pid ]
then
  if [ $(eval "${pidCommand} | wc -l ") -eq 1 ]
  then

    sleep ${timeToStart} &
    timerPid=$!
    tail -n0 -F --pid=$timerPid ${catalinaHome}/logs/catalina.out | {

    ${catalinaHome}/bin/catalina.sh stop

    serverStat=0
    while read line
    do
      if echo $line | grep -q "OMG, They've killed Kenny"; then
        serverStat=1
        kill $timerPid
        break
      fi
    done

    if [ $serverStat -eq 1 ]
    then
      info="[$(date +"%d-%m-%Y %T")] instance of ${server} WAS STOPPED  (PID: ${pid})"
    else
      info="[$(date +"%d-%m-%Y %T")] instance of ${server} ERROR while stopped  (PID: ${pid})"
    fi

    echo "${info}"  >> ${logDir}/${server}_activity.log

    }

  fi
fi