package com.neusoft.controller;

import com.neusoft.Utils.MD5Utils;
import com.neusoft.domain.User;
import com.neusoft.mapper.UserMapper;
import com.neusoft.response.RegRespObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
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
    public RegRespObj doReg(User user, HttpServletRequest request)
    {
        RegRespObj regRespObj = new RegRespObj();
        User user1 = userMapper.selectByEmail(user.getEmail());
        if(user1==null){
            user.setKissNum(100);
            user.setJoinTime(new Date());
            String passwd = user.getPasswd();
            String pwd = MD5Utils.getPwd(passwd);
            user.setPasswd(pwd);
            int i = userMapper.insertSelective(user);
            if(i>0){
                regRespObj.setStatus(0);
                System.out.println(request.getServletContext().getContextPath());
                regRespObj.setAction(request.getServletContext().getContextPath() + "/");
            }else {
                regRespObj.setStatus(1);
                regRespObj.setMsg("数据库错误，联系管理员");
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
    @RequestMapping("logout")
    public String logout(HttpServletRequest request)
    {
        request.getSession().invalidate();
        return "redirect:" + request.getServletContext().getContextPath() +"/";
    }
    @RequestMapping("login")
    public String login()
    {
        return "user/login";
    }
    @RequestMapping("dologin")
    @ResponseBody
    public RegRespObj dologin(User user,HttpServletRequest request)
    {
        //查询数据库，用email和密码作为条件查询，如果查出来0条记录，登录失败
        //否则，登录成功
        user.setPasswd(MD5Utils.getPwd(user.getPasswd()));
        User userResult = userMapper.selectByEmailAndPass(user);
        RegRespObj regRespObj = new RegRespObj();
        if(userResult == null)
        {
            regRespObj.setStatus(1);
            regRespObj.setMsg("登录失败");
        }
        else
        {
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("userinfo",userResult);
            regRespObj.setStatus(0);
            regRespObj.setAction(request.getServletContext().getContextPath() + "/");
        }

        return regRespObj;
    }

    @RequestMapping("set")
    public String userSetting()
    {
        return "user/set";
    }
    @RequestMapping("upload")
    public void upload(@RequestParam  MultipartFile file) throws IOException {
        String filename = file.getOriginalFilename();
        File file1 = new File("d:/head.jpg");
        file.transferTo(file1);


    }
}
