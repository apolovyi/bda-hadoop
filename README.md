Vagrant Hadoop Cluster

user:password
vagrant:vagrant

Execute following commands on master node (type 'pw' when asked for password):

su - hduser
yes "" | ssh-keygen -t rsa -N ""
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@master
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@node01
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@node02

hdfs namenode -format

start-dfs.sh
start-yarn.sh

Generate file:

echo 'new hello word hello word hello word hello word' > file1.txt

for i in {1..25}; do cat file1.txt file1.txt > file2.txt && mv file2.txt file1.txt; done

{1..25}-> 1.6 Gb

hdfs dfs -mkdir -p /bda_course/exercise01

hdfs dfs -put file1.txt /bda_course/exercise01

dd if=/dev/urandom of=file1.txt bs=1048576 count=1000

hadoop fs -copyFromLocal file1.txt hdfs://master:9000/

hdfs dfs -ls hdfs://master:9000/bda_course/exercise01

Execute wordcount job:

yarn jar hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.0.jar wordcount "hdfs://master:9000/bda_course/exercise01/file1.txt" hdfs://master:9000/output/

Output:
hdfs dfs -cat hdfs://master:9000/output/part-r-00000

stop-dfs.sh
stop-yarn.sh

http://master:9870
http://master:8088
