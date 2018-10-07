package com.sjz.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

/**
 * Created by highness on 2018/3/20 0020.
 */
public class HttpUtil {

    public static String httpGet(String getUrl){
        StringBuffer buffer = new StringBuffer();
        try {
            URL url = new URL(getUrl);
            HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();

            httpUrlConn.setDoOutput(false);
            httpUrlConn.setDoInput(true);
            httpUrlConn.setUseCaches(false);

            httpUrlConn.setRequestMethod("GET");
            httpUrlConn.connect();

// 将返回的输入流转换成字符串
            InputStream is = httpUrlConn.getInputStream();
            InputStreamReader reader = new InputStreamReader(is, "utf-8");
            BufferedReader bufferedReader = new BufferedReader(reader);

            String str = null;
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }
            bufferedReader.close();
            reader.close();
            // 释放资源
            is.close();
            is = null;
            httpUrlConn.disconnect();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (ProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return buffer.toString();
    }

}
