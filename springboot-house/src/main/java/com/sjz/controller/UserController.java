package com.sjz.controller;

import com.sjz.entity.User;
import com.sjz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by ZSX on 2018/1/18.
 *
 * @author ZSX
 */
@RestController
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/users")
    public List<User> getUserList() {
        return userService.getAll();
    }

}
