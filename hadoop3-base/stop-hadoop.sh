#!/bin/bash

# stop Hadoop services
# stop hdfs
$HADOOP_HDFS_HOME/sbin/stop-dfs.sh
# stop historyserver
$HADOOP_MAPRED_HOME/bin/mapred --daemon stop historyserver
# stop yarn
$HADOOP_YARN_HOME/sbin/stop-yarn.sh
