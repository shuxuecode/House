package com.sjz.controller.api;

import com.sjz.entity.RentImages;
import com.sjz.service.HouseImageService;
import com.sjz.util.QiniuUtil;
import com.sjz.vo.json.JsonData;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ClassUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * app端上传文件接口
 */
@RequestMapping("upload")
@Controller
public class UploadController {

    private final static Log logger = LogFactory.getLog(UploadController.class);

    @Autowired
    private HouseImageService houseImageService;

    /**
     * 上传文件接口
     * 1、支持并发
     * 2、支持分块上传
     * 3、TODO 断点续传
     *
     * @param file
     * @param request
     * @return
     */
    @RequestMapping(value = "uploadImage")
    @ResponseBody
    public JsonData uploadMedia(
            @RequestParam(value = "stream", required = true) MultipartFile file,
            HttpServletRequest request) {
        InputStream is = null;
        try {
//            String description = request.getParameter("description");

//            String root = request.getSession().getServletContext().getRealPath("/");
//            System.out.println(root);

//            System.out.println(file.isEmpty()); // false

//            System.out.println(file.getContentType()); // image/jpeg
//            System.out.println(file.getName()); // stream
//            System.out.println(file.getOriginalFilename()); // 微信图片_20170830144659.jpg
//            System.out.println(file.getSize()); // 44982  字节
            if (!file.isEmpty()) {
                String originalFilename = file.getOriginalFilename();
                String fileNameSuffix = originalFilename.substring(originalFilename.lastIndexOf("."));
                String fileName = "house_" + UUID.randomUUID().toString() + fileNameSuffix;
                is = file.getInputStream();

                String imgUrl = QiniuUtil.upload(fileName, is);
                if (StringUtils.isNotBlank(imgUrl)) {
                    return JsonData.success(imgUrl);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (is != null) {
                    is.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return JsonData.fail("上传失败");
    }


    /**
     * 上传并保存图片到表
     *
     * @param file
     * @param request
     * @return
     */
    @RequestMapping(value = "addImage")
    @ResponseBody
    public JsonData addImage(
            @RequestParam(value = "tupian", required = true) MultipartFile file,
            HttpServletRequest request) {
        InputStream is = null;
        try {
            String houseId = request.getParameter("houseId");
            System.out.println(houseId);


//            file.transferTo();

//            System.out.println(file.isEmpty()); // false

//            System.out.println(file.getContentType()); // image/jpeg
//            System.out.println(file.getName()); // stream
//            System.out.println(file.getOriginalFilename()); // 微信图片_20170830144659.jpg
//            System.out.println(file.getSize()); // 44982  字节
            if (!file.isEmpty()) {
                String originalFilename = file.getOriginalFilename();
                String fileNameSuffix = originalFilename.substring(originalFilename.lastIndexOf("."));
                String uuid = UUID.randomUUID().toString();
                String tempFileName = "house_" + uuid + fileNameSuffix;
                String format = new SimpleDateFormat("yyMMdd").format(new Date());
                String fileName = "house_" + format + "_" + uuid + fileNameSuffix;

//              获取图片的临时存储路径
                String picturePath = getPicturePath(request);
//              暂存
                file.transferTo(new File(picturePath + tempFileName));

                File tempFile = new File(picturePath + tempFileName);

//                获取图片的宽高
                BufferedImage bufferedImage = ImageIO.read(tempFile);
                int width = bufferedImage.getWidth(null);
                int height = bufferedImage.getHeight(null);
//                处理后的宽高
                int[] widthHeight = getWidthHeight(width, height);
                width = widthHeight[0];
                height = widthHeight[1];

                InputStream tempFileIs = new FileInputStream(tempFile);
                Thumbnails
                        .of(tempFileIs)
                        .sourceRegion(Positions.CENTER, width, height)
                        .size(400, 300)
                        .keepAspectRatio(false) // 不锁定宽高比
//                        .scale(0.5f) // 图片缩小一半
                        .outputQuality(0.9f) // 设置图片质量
                        .toFile(new File(picturePath + fileName));

                is = new FileInputStream(new File(picturePath + fileName));
//                is = file.getInputStream();

                String imgUrl = QiniuUtil.upload(fileName, is);
                if (StringUtils.isNotBlank(imgUrl)) {
                    RentImages rentImages = new RentImages();
                    rentImages.setHouseId(Long.valueOf(houseId));
                    rentImages.setSort(99);
                    rentImages.setImgUrl(imgUrl);
                    rentImages.setDel(0);
                    rentImages.setCreateTime(new Date());
                    rentImages.setUpdateTime(new Date());
                    rentImages.setCreatorId("");
                    rentImages.setCreatorName("");
                    rentImages.setUpdaterId("");
                    rentImages.setUpdaterName("");

                    RentImages images = houseImageService.saveRentImages(rentImages);
                    if (images != null) {
                        return JsonData.returnObject(images);
                    }
                }

                if (tempFileIs != null) {
                    tempFileIs.close();
                }
                if (is != null) {
                    is.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

        }
        return JsonData.fail("上传失败");
    }


    private String getPicturePath(HttpServletRequest request) {
        String yyyyMMdd = new SimpleDateFormat("yyyyMMdd").format(new Date(System.currentTimeMillis()));
        String path = ClassUtils.getDefaultClassLoader().getResource("").getPath();
        path = path + "static" + File.separator + "images" + File.separator + yyyyMMdd + File.separator;


//        String root = request.getSession().getServletContext().getRealPath("/");
//        System.out.println(root);
//        root = root + "housePicture" + File.separator + "img" + File.separator;
//        System.out.println(root);
        File rootFile = new File(path);
//            路径不存在，则创建
        if (!rootFile.exists()) {
            rootFile.mkdirs();
        }
        return path;
    }

    private int[] getWidthHeight(int width, int height) {
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
