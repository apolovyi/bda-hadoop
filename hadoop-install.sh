#!/bin/bash

hdGroup='sudo'
hdUserName='hduser'

sudo apt-get --quiet update
sudo apt-get --quiet -y install openjdk-8-jdk 

echo "Adding HADOOP user"

echo -e 'pw\npw\n' | sudo adduser --gecos "" --ingroup $hdGroup $hdUserName

echo "New $hdUserName USER is created"

echo "Installing SSH"

sudo apt-get -q -y install ssh

echo "Adding host info"

sudo truncate -s 0 /etc/hosts
echo '127.0.0.1	 localhost' | sudo tee -a /etc/hosts
sudo sed -i '1i10.0.0.10  master' /etc/hosts
sudo sed -i '1i10.0.0.11  node01' /etc/hosts
sudo sed -i '1i10.0.0.12  node02' /etc/hosts

# echo "Move hadoop 3.1.0"
# sudo tar xfz /vagrant/files/hadoop-3.1.0.tar.gz
# sudo mv hadoop-3.1.0 /home/$hdUserName/hadoop

#Download hadoop3.1.0 from apache
sudo wget -q http://archive.apache.org/dist/hadoop/core/hadoop-3.1.0/hadoop-3.1.0.tar.gz  
sudo tar xfz hadoop-3.1.0.tar.gz
sudo mv hadoop-3.1.0 /home/$hdUserName/hadoop

sudo chown -R $hdUserName:$hdGroup /home/$hdUserName/hadoop

#Creating tmp folder for hadoop under hadoop/app/hadoop/tmp 
sudo -u $hdUserName mkdir -p /home/$hdUserName/hadoop/app/hadoop/tmp
sudo -u $hdUserName chown -R $hdUserName:$hdGroup /home/$hdUserName/hadoop/app/hadoop/tmp

#Creating hadoop storage location for NameNode and DataNode under hadoop/data/hdfs
sudo -u $hdUserName mkdir -p /home/$hdUserName/hadoop/data/hdfs/namenode
sudo -u $hdUserName mkdir -p /home/$hdUserName/hadoop/data/hdfs/datanode

sudo -u $hdUserName chown -R $hdUserName:$hdGroup /home/$hdUserName/hadoop/data

#hadoop-env.sh
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' | tee -a /home/$hdUserName/hadoop/etc/hadoop/hadoop-env.sh

#.bashrc
echo -e '\n\n export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \n #Hadoop Variable START \n export HADOOP_HOME=/home/'$hdUserName'/hadoop \n export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop \n export HADOOP_INSTALL=$HADOOP_HOME \n export HADOOP_MAPRED_HOME=$HADOOP_HOME \n export HADOOP_COMMON_HOME=$HADOOP_HOME \n export HADOOP_HDFS_HOME=$HADOOP_HOME \n export YARN_HOME=$HADOOP_HOME \n export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native \n export PATH=$PATH:$HADOOP_HOME/sbin/:$HADOOP_HOME/bin \n export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib/native"\n #Hadoop Variable END\n\n' >> /home/$hdUserName/.bashrc
source /home/$hdUserName/.bashrc

echo 'master' | sudo tee -a /home/$hdUserName/hadoop/etc/hadoop/masters

sudo truncate -s 0 /home/$hdUserName/hadoop/etc/hadoop/workers
echo -e 'node01\nnode02' | sudo tee -a /home/$hdUserName/hadoop/etc/hadoop/workers

echo "HADOOP DIRECTORY"
sudo ls /home/$hdUserName/hadoop/
