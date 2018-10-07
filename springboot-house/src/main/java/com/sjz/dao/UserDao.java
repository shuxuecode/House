package com.sjz.dao;

import com.sjz.entity.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Created by ZSX on 2018/1/18.
 *
 * @author ZSX
 */
@Mapper
public interface UserDao {

    List<User> selectAll();

}
