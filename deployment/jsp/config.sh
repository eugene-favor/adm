#!/bin/bash

NEW_DIR=`date +"%d%m%y_%H%M%S"`

#make server list associative array
declare -A servers

servers["someservername"]="(someservername.somegamename.com /opt/somegamename/someservername 80 6080)"
servers["someservername1"]="(someservername1.somegamename.com /opt/somegamename/someservername1 80 6080)"
servers["someservername2"]="(someservername2.somegamename.com /opt/somegamename/someservername2 80 6080)"
