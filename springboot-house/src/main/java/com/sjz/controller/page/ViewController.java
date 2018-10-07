package com.sjz.controller.page;

import com.sjz.service.HouseService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 页面跳转公共controller
 */
@ApiIgnore
@Controller
public class ViewController {

    @Autowired
    private HouseService houseService;

//*************************************
//        房屋列表
//*************************************

    /**
     * 跳转到房屋列表页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/house/houseListPage")
    public String toHouseListPage(HttpServletRequest request) {
//        D:\git\gitee\house\springboot-house\src\main\webapp\WEB-INF\view\jsp\house\houseList.jsp
        return "jsp/house/houseList";
    }

    /**
     * 房间编辑页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/house/houseEditPage")
    public String toHouseEditPage(HttpServletRequest request) {
        String houseId = request.getParameter("houseId");
        if (StringUtils.isBlank(houseId)) {
            houseId = "";
        }
        request.setAttribute("houseId", houseId);
        return "jsp/house/houseEdit";
    }

    /**
     * 地图页面，用于获取房屋坐标
     *
     * @param request
     * @return
     */
    @RequestMapping("/house/houseMapPage")
    public String toHouseMapPage(HttpServletRequest request) {
        String houseId = request.getParameter("houseId");
        if (StringUtils.isBlank(houseId)) {
            houseId = "";
        }
        request.setAttribute("houseId", houseId);
        List<String> list = null;
        if (StringUtils.isNotBlank(houseId)) {
            list = houseService.getRentHouseCoordinates(Long.valueOf(houseId));
        }
        if (CollectionUtils.isNotEmpty(list)) {
            request.setAttribute("longitude", list.get(0));
            request.setAttribute("latitude", list.get(1));
        } else {
            request.setAttribute("longitude", "");
            request.setAttribute("latitude", "");
        }
//        return "jsp/house/houseMap";
        return "jsp/qqMap/houseMap";
    }


//*************************************
//        房屋图片列表
//*************************************

    /**
     * 房屋图片列表页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/house/imageListPage")
    public String toHouseImgListPage(HttpServletRequest request) {
        String houseId = request.getParameter("houseId");
        if (StringUtils.isBlank(houseId)) {
            houseId = "";
        }
        request.setAttribute("houseId", houseId);
//        D:\git\oschina\house\springboot-house\src\main\webapp\WEB-INF\view\jsp\houseImage\imageList.jsp
        return "jsp/houseImage/imageList";
    }
}
