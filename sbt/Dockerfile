FROM belgacea/alpine-spark:2.4.0-hadoop2.7-master

ENV SCALA_VERSION 2.11.11
ENV SBT_VERSION 1.2.7
ENV PATH /sbt/bin:$PATH

# Install Scala
## Piping curl directly in tar
RUN curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
    echo >> /root/.bashrc && \
    echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN wget https://piccolo.link/sbt-$SBT_VERSION.tgz && \
  tar -xzvf sbt-$SBT_VERSION.tgz && \
  sbt sbtVersion

# Define working directory
WORKDIR /root

# Sources :
# https://github.com/intenthq/sbt-alpine/blob/master/Dockerfile
# https://github.com/big-data-europe/docker-spark
# https://bitbucket.org/bitbucketpipelines/scala-sbt/src/master/Dockerfile
