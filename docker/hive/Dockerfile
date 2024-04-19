FROM apache/hive:4.0.0

USER root

RUN apt-get update && apt-get install -y curl

RUN curl https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar \
    --output /opt/hive/lib/aws-java-sdk-bundle-1.12.262.jar
RUN curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.6/hadoop-aws-3.3.6.jar \
    --output /opt/hive/lib/hadoop-aws-3.3.6.jar
COPY ./hive-site.xml /opt/hive/conf/hive-site.xml
