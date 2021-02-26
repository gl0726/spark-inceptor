package com.haizhi.inceptor

import org.apache.commons.lang3.StringUtils
import org.apache.spark.sql.SparkSession
import org.slf4j.{Logger, LoggerFactory}

object Demo {

  private val logger: Logger = LoggerFactory.getLogger(classOf[Demo])
  private val sqlStr: String = " select * from "

  def main(args: Array[String]): Unit = {

    logger.info("====================================================")
    logger.info("===================Application Start================")
    logger.info("====================================================")

    if (args.length == 0 || StringUtils.isBlank(args(0))) {
      throw new Exception(" 启动无表名参数异常 ")
    }

    val spark: SparkSession = SparkSession.builder()
      .appName(" spark read inceptor ")
      .enableHiveSupport()
      .getOrCreate()

    //导入隐式转换
    import spark.sql

    logger.info(s" load inceptor , sql : ${sqlStr.concat(args(0))}")
    sql(" show databases ").show()
    sql(sqlStr.concat(args(0))).show()
    spark.stop()
    logger.info("==========================End=======================")
  }

  case class Demo()

}
