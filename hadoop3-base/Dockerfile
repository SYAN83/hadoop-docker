# Hadoop base image
#
# VERSION 0.1

# GNU/Linux platform with requisite software
FROM linux-base:0.1

LABEL maintainer="yanshu.usc@gmail.com"
LABEL description="Single-node Hadoop 3 cluster pseudo-distributed mode."

ENV HADOOP_VER hadoop-3.2.1
ENV HADOOP_HOME=/usr/local/$HADOOP_VER
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
# ENV CLASSPATH_PREPEND_DISTCACHE
ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_LOG_DIR=$HADOOP_HOME/logs

ARG user=hadoop
USER root

# copy Hadoop distribution and configuration
COPY $HADOOP_VER $HADOOP_HOME
COPY conf /conf/
COPY start-hadoop.sh /usr/local/bin/	
COPY stop-hadoop.sh /usr/local/bin/	

# create hadoop user
RUN adduser --disabled-password --gecos '' $user
RUN adduser $user sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chown -R hadoop:hadoop $HADOOP_HOME
RUN ln -s ${HADOOP_HOME} /usr/local/hadoop

# set user and workdir 
USER $user
WORKDIR /home/$user

RUN cp /conf/core-site.xml $HADOOP_CONF_DIR
RUN cp /conf/hdfs-site.xml $HADOOP_HDFS_HOME/etc/hadoop
RUN cp /conf/mapred-site.xml $HADOOP_MAPRED_HOME/etc/hadoop
RUN cp /conf/yarn-site.xml $HADOOP_YARN_HOME/etc/hadoop
RUN mkdir $HADOOP_LOG_DIR
RUN sed -i "/export JAVA_HOME=/c\export JAVA_HOME=$JAVA_HOME" $HADOOP_CONF_DIR/hadoop-env.sh

# setup passphraseless ssh
RUN ssh-keygen -t rsa -P '' -f $HOME/.ssh/id_rsa
RUN cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
RUN chmod 0600 $HOME/.ssh/authorized_keys
RUN cp /conf/ssh_config $HOME/.ssh/config
RUN sudo sh -c 'echo ssh > /etc/pdsh/rcmd_default'

# Format the filesystem
RUN ${HADOOP_HOME}/bin/hdfs namenode -format

# expose webapp ports
# resourcemanager 
EXPOSE 8088
# nodemanager
EXPOSE 8042
# namenode
EXPOSE 9870
# datanode
EXPOSE 9864
# jobhistory
EXPOSE 19888

ENTRYPOINT sudo /etc/init.d/ssh start; start-hadoop.sh; bash