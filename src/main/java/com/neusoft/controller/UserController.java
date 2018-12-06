package com.neusoft.controller;

import com.neusoft.domain.User;
import com.neusoft.mapper.UserMapper;
import com.neusoft.response.RegRespObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Administrator on 2018/12/6.
 */
@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    UserMapper userMapper;
    @RequestMapping("reg")
    public String reg()
    {
        return "user/reg";
    }

    @RequestMapping("doreg")
    @ResponseBody
    public RegRespObj doReg(User user)
    {
        RegRespObj regRespObj = new RegRespObj();
        User user1 = userMapper.selectByEmail(user.getEmail());
        if(user1==null){
            int i = userMapper.insertSelective(user);
            if(i>0){
                regRespObj.setStatus(0);
                regRespObj.setAction("/");
            }else {
                regRespObj.setStatus(1);
                regRespObj.setAction("数据库错误，联系管理员");
            }
        }else {
            regRespObj.setStatus(1);
            regRespObj.setMsg("邮箱重复，请换邮箱注册");
        }

        return regRespObj;

    }
    @RequestMapping("/checkEmail")
    @ResponseBody
    public RegRespObj checkEmail(User user){
        RegRespObj regRespObj = new RegRespObj();
        User user1 = userMapper.selectByEmail(user.getEmail());
        if(user1==null){
            regRespObj.setMsg("可以注册");
        }else {
            regRespObj.setMsg("邮箱重复，请更换邮箱");
        }
        return regRespObj;
    }

    @RequestMapping("login")
    public String login()
    {
        return "user/login";
    }
}
