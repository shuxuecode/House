package com.sjz.service.impl;

import com.sjz.dao.UserDao;
import com.sjz.entity.User;
import com.sjz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by ZSX on 2018/1/18.
 *
 * @author ZSX
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public List<User> getAll() {
        return userDao.selectAll();
    }


}
