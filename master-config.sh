#!/bin/bash
hdUserName='hduser'

#-----remove current configuration
#core-site.xml
sudo sed -i '/<configuration>/,/<\/configuration>/{//!d}' /home/$hdUserName/hadoop/etc/hadoop/core-site.xml
#mapred-site.xml
sudo sed -i '/<configuration>/,/<\/configuration>/{//!d}' /home/$hdUserName/hadoop/etc/hadoop/mapred-site.xml
#hdfs-site.xml
sudo sed -i '/<configuration>/,/<\/configuration>/{//!d}' /home/$hdUserName/hadoop/etc/hadoop/hdfs-site.xml
#yarn-site.xml
sudo sed -i '/<configuration>/,/<\/configuration>/{//!d}' /home/$hdUserName/hadoop/etc/hadoop/yarn-site.xml


#------add new configuration
#core-site.xml
sudo sed -i '/<configuration>/a <property> <name>hadoop.tmp.dir</name> <value>/home/'$hdUserName'/hadoop/app/hadoop/tmp</value> </property> <property> <name>fs.default.name</name> <value>hdfs://master:9000</value> </property>' /home/$hdUserName/hadoop/etc/hadoop/core-site.xml
#mapred-site.xml
sudo sed -i '/<configuration>/a <property> <name>mapreduce.jobtracker.address</name> <value>master:54311</value> </property> <property>  <name>mapreduce.framework.name</name>  <value>yarn</value> </property> <property> <name>yarn.app.mapreduce.am.env</name> <value>HADOOP_MAPRED_HOME=$HADOOP_MAPRED_HOME</value> </property> <property> <name>mapreduce.map.env</name> <value>HADOOP_MAPRED_HOME=$HADOOP_MAPRED_HOME</value> </property> <property> <name>mapreduce.reduce.env</name> <value>HADOOP_MAPRED_HOME=$HADOOP_MAPRED_HOME</value> </property>' /home/$hdUserName/hadoop/etc/hadoop/mapred-site.xml
#hdfs-site.xml
sudo sed -i '/<configuration>/a <property> <name>dfs.replication</name> <value>2</value> </property> <property> <name>dfs.namenode.name.dir</name> <value>/home/'$hdUserName'/hadoop/data/hdfs/namenode</value> </property> <property> <name>dfs.datanode.data.dir</name> <value>/home/'$hdUserName'/hadoop/data/hdfs/datanode</value> </property> <property> <name>dfs.block.size</name> <value>134217728</value> </property>' /home/$hdUserName/hadoop/etc/hadoop/hdfs-site.xml
#yarn-site.xml
sudo sed -i '/<configuration>/a <property> <name>yarn.acl.enable</name> <value>0</value> </property> <property> <name>yarn.resourcemanager.hostname</name> <value>master</value> </property> <property> <name>yarn.nodemanager.aux-services</name> <value>mapreduce_shuffle</value> </property>  <property> <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name> <value>org.apache.hadoop.mapred.ShuffleHandler</value> </property> <property> <name>yarn.log-aggregation-enable</name> <value>true</value> </property> ' /home/$hdUserName/hadoop/etc/hadoop/yarn-site.xml
