package com.sjz.config.schedule;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.util.ClassUtils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by ZSX on 2018/3/20.
 *
 * @author ZSX
 */
@Configuration
@EnableScheduling
public class TimeTask {

    private static final Logger logger = LoggerFactory.getLogger(TimeTask.class);

//    @Scheduled(cron = "0/60 * * * * ?")
//    @Scheduled(cron = "0/10 * * * * ?")
//    @Scheduled(cron = "01-05 * * * * ?")
    @Scheduled(cron = "00 00 01-02 * * ?")
    public void main22() {
        deleteTempImage();
    }


    /**
     * 删除昨天的临时文件夹
     */
    public static void deleteTempImage(){
        logger.info("开始执行删除昨天临时文件夹的任务");
//        当前时间减去24小时即为昨天
        long millTime = System.currentTimeMillis() - 24 * 60 * 60 * 1000;
//        昨天的临时文件夹名称
        String yyyyMMdd = new SimpleDateFormat("yyyyMMdd").format(new Date(millTime));
//        根目录
        String path = ClassUtils.getDefaultClassLoader().getResource("").getPath();
        path = path + "static" + File.separator + "images" + File.separator + yyyyMMdd + File.separator;
        File file = new File(path);
        if (file.exists()){
//            如果存在，则获取它的子文件，然后逐一删除
            File[] files = file.listFiles();
            if (files.length > 0){
                for (File child : files) {
                    child.delete();
                }
            }
            file.delete();
        }
    }
}
