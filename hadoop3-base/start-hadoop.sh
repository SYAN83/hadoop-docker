#!/bin/bash

# start Hadoop services
hadoop_user=$(whoami)
# 1 start hdfs
$HADOOP_HDFS_HOME/sbin/start-dfs.sh
# create HDFS directory
if ! $($HADOOP_HDFS_HOME/bin/hdfs dfs -test -d /user) ; then
    echo "Creating hadoop directory"
    $HADOOP_HDFS_HOME/bin/hdfs dfs -mkdir /user
fi
if ! $($HADOOP_HDFS_HOME/bin/hdfs dfs -test -d /user/$hadoop_user) ; then
    $HADOOP_HDFS_HOME/bin/hdfs dfs -mkdir /user/$hadoop_user
fi
# 2 start yarn
$HADOOP_YARN_HOME/sbin/start-yarn.sh
# 3 start historyserver
$HADOOP_MAPRED_HOME/bin/mapred --daemon start historyserver

# welcome screen
echo
figlet -f slant Hadoop Base
echo
cat /etc/lsb-release | grep DISTRIB_DESCRIPTION | cut -d \" -f2
hadoop version | head -n 1
echo
