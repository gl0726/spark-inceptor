#!/usr/bin/bash
#source /etc/profile
#source ~/.bashrc
#source ~/.bash_profile

#cd $(dirname $0)/..
#source $1

DIR=$(cd `dirname $0`; cd ..; pwd)
cd $DIR
echo " path = $DIR"

user_name=$1
keytab=$2
input_param=$3

echo "kerberos username ${user_name}"
echo "kerberos keytab ${keytab}"
echo "start execute with sparkArgs ${input_param}"

#kerberos_str=""

#if [ ${kerberos} -eq 1 ]; then
#    kinit -kt ${keytab} ${principal}
#    kerberos_str="--principal ${principal} --keytab ${keytab}"
#fi

kerberos_str="--principal ${user_name} --keytab ${keytab}"


spark-submit \
  ${kerberos_str} \
  --master yarn \
  --deploy-mode cluster \
  --num-executors 1 \
  --executor-cores 2 \
  --executor-memory 2g \
  --queue bigdata \
  --name spark_read_inceptor_demo
  --conf "spark.yarn.dist.archives=./jdk/jdk-8u261-linux-x64.tar.gz" \
  --conf "spark.executorEnv.JAVA_HOME=./jdk-8u261-linux-x64.tar.gz/jdk1.8.0_261" \
  --conf "spark.yarn.appMasterEnv.JAVA_HOME=./jdk-8u261-linux-x64.tar.gz/jdk1.8.0_261" \
  --conf spark.driver.extraClassPath=lib/* \
  --conf spark.executor.extraClassPath=lib/* \
  --conf spark.driver.memory=2g \
  --conf spark.default.parallelism=2 \
  --jars $(echo $(ls lib/*.jar | grep -v "spark-inceptor-*.jar") | tr ' ' ',') \
  --files ${SPARK_HOME}/conf/yarn-conf/hive-site.xml \
  --class com.haizhi.inceptor.Demo \
  ./lib/spark-inceptor-*.jar ${input_param}

exit
