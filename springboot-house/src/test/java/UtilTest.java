import com.alibaba.fastjson.JSON;
import com.sjz.App;
import com.sjz.service.HouseService;
import com.sjz.util.PageData;
import com.sjz.vo.HouseVO;
import com.sjz.vo.app.HouseList;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.math.BigDecimal;
import java.util.HashMap;


@RunWith(SpringRunner.class)
@SpringBootTest(classes = App.class)
@WebAppConfiguration
public class UtilTest {

    @Autowired
    private HouseService houseService;

    @Test
    public void test1() {
        String str = "600-799";
        String[] split = str.split("-");
        BigDecimal rentalStart = new BigDecimal(split[0]);
        BigDecimal rentalEnd = new BigDecimal(split[1]);

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("districtId", 102L);
        map.put("rentalStart", rentalStart);
        map.put("rentalEnd", rentalEnd);

        PageData<HouseList> pageList = houseService.getRentHousePageList(map, 1, 10);
        System.out.println(JSON.toJSONString(pageList));

    }

    @Test
    public void test11() {
        HouseVO rentHouseDetail = houseService.getRentHouseDetail("", 2002L);
        System.out.println();
        System.out.println(JSON.toJSONString(rentHouseDetail));
        System.out.println();

    }

}