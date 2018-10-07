package com.sjz.util;

import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;

import java.io.InputStream;

/**
 * Created by ZSX on 2018/3/13.
 *
 * @author ZSX
 */

public class QiniuUtil {

    private final static String accessKey = "";
    private final static String secretKey = "";
    private final static String bucket = "highness";
    private final static String url = "http://highness.qiniudn.com/";

    public static void main(String[] args) {
        upload("house_1223.jpg", null);


        String str = "for+PC（Smartisan+Wallpaper+Idea+Pills）.jpg";
        int i = str.lastIndexOf(".");
        System.out.println(i);
        System.out.println(str.substring(0, i));
        System.out.println(str.substring(i));
        /*
        38
for+PC（Smartisan+Wallpaper+Idea+Pills）
.jpg
         */
    }

    public static String upload(String fileName, InputStream is) {
        //构造一个带指定Zone对象的配置类
        Configuration cfg = new Configuration(Zone.zone0());

        UploadManager uploadManager = new UploadManager(cfg);
        //...生成上传凭证，然后准备上传

        //默认不指定key的情况下，以文件内容的hash值作为文件名
        String key = fileName;

        Auth auth = Auth.create(accessKey, secretKey);
        String upToken = auth.uploadToken(bucket);
        try {
//            is = new FileInputStream(new File("D:\\911.jpg"));
//            Response response = uploadManager.put(localFilePath, key, upToken);
            Response response = uploadManager.put(is, key, upToken, null, null);
//            System.out.println(JSON.toJSONString(response, true));
            //解析上传成功的结果
//            DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
//            System.out.println(JSON.toJSONString(putRet));
//            System.out.println(putRet.key);
//            System.out.println(putRet.hash);
            if (response.isOK()) {
                return url + fileName;
            }
        } catch (QiniuException ex) {
            Response r = ex.response;
            System.err.println(r.toString());
            try {
                System.err.println(r.bodyString());
            } catch (QiniuException ex2) {
                //ignore
            }
        }
        return null;
    }

    
}
