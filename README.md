# Spark docker sbt
*Spark docker images based on alpine linux*

Docker images to:
* Setup a standalone [Apache Spark](http://spark.apache.org/) cluster running one Spark Master and multiple Spark workers
* Build Spark applications in Java, Scala or Python to run on a Spark cluster

Currently supported versions:
* Spark 2.4.0 for Hadoop 2.7+ with OpenJDK 8


## Using Docker Compose

Add the following services to your `docker-compose.yml` to integrate a Spark master and Spark worker in your pipeline :
```yml
spark-master:
  image: belgacea/alpine-spark:2.4.0-hadoop2.7-master
  container_name: spark-master
  ports:
    - "9080:8080"
    - "7077:7077"
  environment:
    - INIT_DAEMON_STEP=setup_spark
    - "constraint:node==<yourmasternode>"
spark-worker-1:
  image: belgacea/alpine-spark:2.4.0-hadoop2.7-worker
  container_name: spark-worker-1
  depends_on:
    - spark-master
  ports:
    - "9081:8081"
  environment:
    - "SPARK_MASTER=spark://spark-master:7077"
    - "constraint:node==<yourmasternode>"
spark-worker-2:
  image: belgacea/alpine-spark:2.4.0-hadoop2.7-worker
  container_name: spark-worker-2
  depends_on:
    - spark-master
  ports:
    - "9081:8081"
  environment:
    - "SPARK_MASTER=spark://spark-master:7077"
    - "constraint:node==<yourworkernode>"
```
Make sure to fill in the `INIT_DAEMON_STEP` as configured in your pipeline.

## Running Docker containers without the init daemon
### Spark Master
To start a Spark master:

    docker run --name spark-master -h spark-master -e ENABLE_INIT_DAEMON=false -d belgacea/alpine-spark:2.4.0-hadoop2.7-master

### Spark Worker
To start a Spark worker:

    docker run --name spark-worker-1 --link spark-master:spark-master -e ENABLE_INIT_DAEMON=false -d belgacea/alpine-spark:2.4.0-hadoop2.7-master

## Launch a Spark application
Building and running your Spark application on top of the Spark cluster is as simple as extending a template Docker image. Check the template's README for further documentation.
* [Java template](https://github.com/belgacea/docker-spark-sbt/tree/master/template/java)
* [Python template](https://github.com/belgacea/docker-spark-sbt/tree/master/template/python)
* [Scala template](https://github.com/belgacea/docker-spark-sbt/tree/master/template/scala)
