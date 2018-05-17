#!/bin/bash
#
# Checking Jenkins offline and restart if offline
#
JENKINS_URL="http://10.70.3.22:8080"
JENKINS_NODE_LINUX=`hostname -s | cut -d'0' -f1`
JENKINS_NODE_NR=`hostname -s | cut -d'0' -f2`
JENKINS_NODENAME="${JENKINS_NODE_LINUX}_slave_node_${JENKINS_NODE_NR}"
CHECKED=`curl --silent $JENKINS_URL/computer/$JENKINS_NODENAME/api/json | grep -Po '"offline":true' | cut -d':' -f2`
if [[ "$CHECKED" == "true" ]]; then
      #  service jenkins-slave restart
        echo "INFO: $JENKINS_NODENAME was offline and are now restarted"
        exit 0
fi
echo "INFO: $JENKINS_NODENAME is online, no need to restart."
exit 0
