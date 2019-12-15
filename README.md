# hadoop-docker-stacks

Opinionated stacks of ready-to-run Hadoop applications in Docker.

## Getting Started

### linux-base

Build image:

```
docker build -t linux-base:0.1 .
```

### hadoop3-base

Build image:

```
docker build -t hadoop3-base .
```

Start container:
```
docker run -it --rm \
  -p 8088:8088 \
  -p 8042:8042 \
  -p 9870:9870 \
  -p 9864:9864 \
  -p 19888:19888 \
  hadoop3-base
```

Test MapReduce in hadoop container:
```
hdfs dfs -mkdir input
hdfs dfs -put $HADOOP_HOME/etc/hadoop/*.xml input
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar wordcount input output
hdfs dfs -ls output
```


