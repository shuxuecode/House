import com.alibaba.fastjson.JSONObject;
import com.sjz.util.HttpUtil;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigDecimal;

/**
 * Created by ZSX on 2018/3/14.
 *
 * @author ZSX
 */
public class MainTest1 {
    public static void main1(String[] args) throws Exception {

//        InputStream is = new FileInputStream(new File("D:/data/1.jpg"));
//        Thumbnails
//                .of(is)
//                .scale(0.5f)
//                .outputQuality(0.5f)
//                .toFile(new File("D:/data/2.jpg"));

        File file = new File("D:/1/2/3/4/");
        System.out.println(file.exists());
        if (!file.exists()) {
            file.mkdirs();
        }
        System.out.println(file.exists());


        System.out.println("0-600".split("-").length);
        System.out.println("5000-99999".split("-").length);

    }


    public static void main2(String[] args) {
        String appid = "";
        String appsecret = "";
        String code = "";
        String url = "https://api.weixin.qq.com/sns/jscode2session?appid=" +
                appid + "&secret=" +
                appsecret + "&js_code=" +
                code + "&grant_type=authorization_code";
        String str = HttpUtil.httpGet(url);
        JSONObject object = JSONObject.parseObject(str);
        System.out.println(object.toJSONString());
        System.out.println(object.getString("openid"));
    }

    public static void main44(String[] args) {
//        System.out.println(reverse(123));
//        System.out.println(reverse(-123));
//        System.out.println(reverse(12300));
//        System.out.println(reverse(-12300));
//        System.out.println(Integer.MAX_VALUE);
        System.out.println(reverse(1534236469));
        System.out.println(reverse(-2147483412));
//        System.out.println(reverse(Integer.MAX_VALUE));
//        System.out.println(reverse(-Integer.MAX_VALUE));
    }

    public static int reverse(int x) {
        boolean minus = x < 0 ? true : false;
        x = x < 0 ? -x : x;
        long n = 0;
        while (x > 0) {
            int num = x % 10;
            n = num + (n * 10);
            if (n > (long) Integer.MAX_VALUE) {
                return 0;
            }
            x /= 10;
        }
        int m = Integer.valueOf(String.valueOf(n));
        return minus ? -m : m;
    }

    public static void main(String[] args) throws Exception {
        String file1 = "D:/1/2/11.jpg";
        File file = new File(file1);
        InputStream tempFileIs = new FileInputStream(file);

        BufferedImage bufferedImage = ImageIO.read(file);
        System.out.println(bufferedImage.getWidth(null));
        System.out.println(bufferedImage.getHeight(null));


        int width = bufferedImage.getWidth(null);
        int height = bufferedImage.getHeight(null);

        int[] widthHeight = getWidthHeight(width, height);

        width = widthHeight[0];
        height = widthHeight[1];

        Thumbnails
                .of(tempFileIs)
                .sourceRegion(Positions.CENTER, width, height)
//                .size(400,300)
                .size(696,522)
                .keepAspectRatio(false)
//                .scale(0.5f)
//                .scale(1f)
                .outputQuality(0.5f)
                .toFile(new File("D:/1/2/22.jpg"));

    }

    private static int[] getWidthHeight(int width, int height) {
        int[] result = new int[2];
        result[0] = width;
        result[1] = height;
        BigDecimal ratio = new BigDecimal("1.33");
        BigDecimal divide = new BigDecimal(width).divide(new BigDecimal(height), 2, BigDecimal.ROUND_HALF_UP);
        if (divide.compareTo(ratio) == 1) {
//          太宽了，取高，然后算出对应比例的宽度
            int newWidth = new BigDecimal(height).multiply(ratio).intValue();
            result[0] = newWidth;
        } else if (divide.compareTo(ratio) == -1) {
//          太高了，取宽，然后算出对应比例的高度
            int newHeight = new BigDecimal(width).divide(ratio, 2, BigDecimal.ROUND_HALF_UP).intValue();
            result[1] = newHeight;
        }
        return result;
    }
}
