import com.alibaba.fastjson.JSON;
import com.sun.mail.util.MailSSLSocketFactory;
import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Properties;

/**
 * Created by highness on 2018/4/14 0014.
 */
public class MailUtil {

    private static Logger logger = Logger.getLogger(MailUtil.class);
    //协议 pop3 smtp
    private static String protocol = "smtp";
    //邮件服务器
    private static String host = "smtphz.qiye.163.com"; //"smtp.exmail.qq.com";
    private static boolean debug = true;
    //用户名和密码
    private static String username = "oss@qding.me"; // "qding@qding.me";
    private static String password = "Qd@2014";
    //发件人
    private static String from = "oss@qding.me";
    // 收件人
    private static String recipient = "xiexiyang@qding.me";

    //是否需要认证
    private static boolean ifAuth = true;

    private static Properties properties;

    public void setDebug(boolean debug) {
        MailUtil.debug = debug;
    }

    public void setFrom(String from) {
        MailUtil.from = from;
    }

    public void setProtocol(String protocol) {
        MailUtil.protocol = protocol;
    }

    public void setHost(String host) {
        MailUtil.host = host;
    }

    public void setUsername(String username) {
        MailUtil.username = username;
    }

    public void setPassword(String password) {
        MailUtil.password = password;
    }

    public void setRecipient(String recipient) {
        MailUtil.recipient = recipient;
    }

    public void setIfAuth(boolean ifAuth) {
        MailUtil.ifAuth = ifAuth;
    }

    private static void init(){
        logger.info("MailUtil init.");
        if(null == MailUtil.properties){
            MailUtil.properties = new Properties();
        }
        MailUtil.properties.setProperty("mail.transport.protocol", MailUtil.protocol); // 协议
//        MailUtil.properties.setProperty("mail.debug", String.valueOf(MailUtil.debug));
        MailUtil.properties.setProperty("mail.host", MailUtil.host); // 服务器
//        MailUtil.properties.setProperty("mail.smtp.port", "465"); // 端口
        MailUtil.properties.setProperty("mail.smtp.port", "25"); // 端口
        MailUtil.properties.setProperty("mail.smtp.auth", String.valueOf(MailUtil.ifAuth)); // 使用smtp身份验证
        //使用SSL，企业邮箱必需！
        //开启安全协议
//        MailSSLSocketFactory sf = null;
//        try {
//            sf = new MailSSLSocketFactory();
//            sf.setTrustAllHosts(true);
//        } catch (GeneralSecurityException e1) {
//            e1.printStackTrace();
//        }
//        MailUtil.properties.put("mail.smtp.ssl.enable", "true"); // 开启SSL加密
//        MailUtil.properties.put("mail.smtp.ssl.socketFactory", sf);
    }

    public static void sendMail(String mailList,String mailBody, String mailTitle){

        String[] recipients = mailList.split(",");
        List<String> recipientEmails = Arrays.asList(recipients);
        MailUtil.init();

        logger.info("MailUtil sendMail. recipientEmails:"+ JSON.toJSONString(recipientEmails) +" mailBody: " + JSON.toJSONString(mailBody));
        try {

            if (CollectionUtils.isEmpty(recipientEmails)) {
                logger.error("收件人为空无法发送邮件");
//                throw new ServiceException(HttpStatus.BAD_REQUEST.getStatusCode(), "收件人为空无法发送邮件");
            }

            //1.创建session
            Session session = Session.getInstance(MailUtil.properties);

            // 开启DEBUG模式,在控制台中或日志中有日志信息显示，也就是可以从控制台中看一下服务器的响应信息；
            session.setDebug(true);
            //2.获取transport对象
            Transport transport = session.getTransport();

            //收件人
            InternetAddress[] internetAddresses = new InternetAddress[recipientEmails.size()];
            for(int i=0; i<recipientEmails.size(); i++){
                internetAddresses[i] = new InternetAddress(recipientEmails.get(i));
            }

            //3.邮件
            Message message = new MimeMessage(session);
            //发送时间
            message.setSentDate(new Date());
            //发件人
            message.setFrom(new InternetAddress(MailUtil.from));
            //主题
            message.setSubject(mailTitle);
            //收件人 TO BCC CC
            message.setRecipients(Message.RecipientType.TO, internetAddresses);

            //邮件内容(正文(可以发送html代码)和附件)
            Multipart multipart = new MimeMultipart();

            //正文或附件内容
            //正文
            BodyPart mimeBodyPartContent = new MimeBodyPart();
            mimeBodyPartContent.setContent(mailBody,"text/html;charset=UTF-8");
            multipart.addBodyPart(mimeBodyPartContent);

            message.setContent(multipart);

            message.saveChanges();

            //4.连接邮件服务器
            transport.connect(MailUtil.username, MailUtil.password);
            //5.发送邮件
            transport.sendMessage(message, message.getAllRecipients());

            //6.关闭连接
            transport.close();
        }catch (Exception e){
            logger.error("发送邮件失败!", e);
            e.printStackTrace();
        }
    }


    public static void main(String[] args) {
        sendMail("zhaoshuxue@qding.me","测试，请忽略","测试邮件");
    }
}
