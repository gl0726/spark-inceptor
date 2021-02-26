#!/usr/bin/bash
#source /etc/profile
#source ~/.bashrc
#source ~/.bash_profile

#cd $(dirname $0)/..
#source $1

DIR=$(cd `dirname $0`; cd ..; pwd)
cd $DIR
echo " path = $DIR"
input_param=$1
echo "start execute with sparkArgs ${input_param}"

#kerberos_str=""

#if [ ${kerberos} -eq 1 ]; then
#    kinit -kt ${keytab} ${principal}
#    kerberos_str="--principal ${principal} --keytab ${keytab}"
#fi

spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --num-executors 1 \
  --executor-cores 2 \
  --executor-memory 2g \
  --conf spark.driver.extraClassPath=lib/* \
  --conf spark.executor.extraClassPath=lib/* \
  --conf spark.driver.memory=2g \
  --conf spark.default.parallelism=2 \
  --jars $(echo $(ls lib/*.jar | grep -v "spark-inceptor-*.jar") | tr ' ' ',') \
  --class com.haizhi.inceptor.Demo \
  ./lib/spark-inceptor-*.jar ${input_param}

exit
