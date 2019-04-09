# BDA Hadoop Cluster

One Paragraph of project description goes here

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Install Vagrant
https://www.vagrantup.com/downloads.html

Install Virtual Box
https://www.virtualbox.org/wiki/Downloads

### Installing

To create VM's run

```
vagrant up
```

it will take a while...
...

When done, log in to master node with vagrant user (password: 'vagrant')

Execute following commands on master node (type 'pw' when asked for password):

```
su - hduser

yes "" | ssh-keygen -t rsa -N ""

ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@master

ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@node01

ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@node02

hdfs namenode -format

start-dfs.sh

start-yarn.sh
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

Links to hadoop web interfaces
http://master:9870
http://master:8088

To stop hadoop cluster:

```
stop-dfs.sh
stop-yarn.sh
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

- [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
- [Maven](https://maven.apache.org/) - Dependency Management
- [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

- **Billie Thompson** - _Initial work_ - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc
