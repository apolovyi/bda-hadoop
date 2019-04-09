# BDA Hadoop Cluster

Vagrant setup for hadoop cluster of one master node and two slave nodes.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

Install Vagrant  
https://www.vagrantup.com/downloads.html

Install Virtual Box  
https://www.virtualbox.org/wiki/Downloads

### Installing

To create VM's run:

```
vagrant up
```

it will take a while...

### Finishing installation

When all three virtual machines are running, log in to master node (password for Vagrant: 'vagrant').

Open terminal and execute following commands on master node (type 'pw' when asked for password):

```
su - hduser

yes "" | ssh-keygen -t rsa -N ""

ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@master

ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@node01

ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@node02
```

### Running hadoop cluster

```
hdfs namenode -format

start-dfs.sh

start-yarn.sh
```

To generate file run following:

```
echo 'hello new word hello old word hello word hello word' > file1.txt

for i in {1..23}; do cat file1.txt file1.txt > file2.txt && mv file2.txt file1.txt; done
```

After 23 iterations you will get 436 Mb file, after 25 - 1.7 Gb.

Create directory for file and put it there

```
hdfs dfs -mkdir -p /bda_course/exercise01

hdfs dfs -put file1.txt /bda_course/exercise01
```

Execute wordcount job:

```
yarn jar hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.0.jar wordcount "hdfs://master:9000/bda_course/exercise01/file1.txt" hdfs://master:9000/output/
```

To check output run:

```
hdfs dfs -cat hdfs://master:9000/output/part-r-00000
```

Links to hadoop web interfaces:  
http://master:9870  
http://master:8088

To stop hadoop cluster:

```
stop-dfs.sh

stop-yarn.sh
```
