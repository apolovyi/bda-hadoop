#!/bin/bash
hdGroup='hdgroup'
hdUserName='hduser'

# update system and install java8
sudo apt-get update
sudo apt-get -y install openjdk-8-jdk 

# add hadoop user
sudo addgroup hdgroup
echo -e 'pw\npw\n' | sudo adduser --gecos "" --ingroup $hdGroup $hdUserName
sudo usermod -aG sudo $hdUserName

# install ssh
sudo apt-get -y install ssh

# configure host file
echo "Adding host info"
sudo truncate -s 0 /etc/hosts
echo '127.0.0.1	 localhost' | sudo tee -a /etc/hosts
sudo sed -i '1i10.0.0.10  master' /etc/hosts
sudo sed -i '1i10.0.0.11  node01' /etc/hosts
sudo sed -i '1i10.0.0.12  node02' /etc/hosts

# echo "Move hadoop 3.1.0"
# sudo tar xfz /vagrant/files/hadoop-3.1.0.tar.gz
# sudo mv hadoop-3.1.0 /home/$hdUserName/hadoop

echo "Downloading and unpacking hadoop 3.1.0"
sudo wget -q http://archive.apache.org/dist/hadoop/core/hadoop-3.1.0/hadoop-3.1.0.tar.gz  
sudo tar xfz hadoop-3.1.0.tar.gz
sudo rm hadoop-3.1.0.tar.gz
echo "Moving hadoop 3.1.0 to /home/$hdUserName/hadoop"
sudo mv hadoop-3.1.0 /home/$hdUserName/hadoop

sudo chown -R $hdUserName:$hdGroup /home/$hdUserName/hadoop

# create tmp folder for hadoop
sudo -u $hdUserName mkdir -p /home/$hdUserName/hadoop/app/hadoop/tmp
sudo -u $hdUserName chown -R $hdUserName:$hdGroup /home/$hdUserName/hadoop/app/hadoop/tmp

# create hadoop storage location for namenode and datanode"
sudo -u $hdUserName mkdir -p /home/$hdUserName/hadoop/data/hdfs/namenode
sudo -u $hdUserName mkdir -p /home/$hdUserName/hadoop/data/hdfs/datanode
sudo -u $hdUserName chown -R $hdUserName:$hdGroup /home/$hdUserName/hadoop/data

#hadoop-env.sh
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' | tee -a /home/$hdUserName/hadoop/etc/hadoop/hadoop-env.sh

#.bashrc
echo -e '\n\n export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \n #Hadoop Variable START \n export HADOOP_HOME=/home/'$hdUserName'/hadoop \n export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop \n export HADOOP_INSTALL=$HADOOP_HOME \n export HADOOP_MAPRED_HOME=$HADOOP_HOME \n export HADOOP_COMMON_HOME=$HADOOP_HOME \n export HADOOP_HDFS_HOME=$HADOOP_HOME \n export YARN_HOME=$HADOOP_HOME \n export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native \n export PATH=$PATH:$HADOOP_HOME/sbin/:$HADOOP_HOME/bin \n export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib/native"\n #Hadoop Variable END\n\n' >> /home/$hdUserName/.bashrc
source /home/$hdUserName/.bashrc

# add master and worker nodes to configuration
sudo truncate -s 0 /home/$hdUserName/hadoop/etc/hadoop/masters
echo 'master' | sudo tee -a /home/$hdUserName/hadoop/etc/hadoop/masters
sudo truncate -s 0 /home/$hdUserName/hadoop/etc/hadoop/workers
echo -e 'node01\nnode02' | sudo tee -a /home/$hdUserName/hadoop/etc/hadoop/workers
