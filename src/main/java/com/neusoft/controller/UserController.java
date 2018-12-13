package com.neusoft.controller;

import com.neusoft.Utils.MD5Utils;
import com.neusoft.Utils.StringDate;
import com.neusoft.domain.User;
import com.neusoft.mapper.CommentMapper;
import com.neusoft.mapper.TopicMapper;
import com.neusoft.mapper.UserCollectTopicMapper;
import com.neusoft.mapper.UserMapper;
import com.neusoft.response.PageInfo;
import com.neusoft.response.RegRespObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sun.util.calendar.LocalGregorianCalendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2018/12/6.
 */
@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    UserMapper userMapper;
    @Autowired
    TopicMapper topicMapper;
    @Autowired
    CommentMapper commentMapper;
    @Autowired
    UserCollectTopicMapper userCollectTopicMapper;
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
            String referer = (String) httpSession.getAttribute("referer");
            httpSession.removeAttribute("referer");

            regRespObj.setStatus(0);
            if(referer==null){
                regRespObj.setAction(request.getServletContext().getContextPath() + "/");
            }else {
                regRespObj.setAction(referer);
            }
        }
        return regRespObj;
    }

    @RequestMapping("set")
    public String userSetting()
    {
        return "user/set";
    }
    @RequestMapping("doSetting")
    @ResponseBody
    public RegRespObj doSetting(User user,HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        User user1 = userMapper.selectByEmail(user.getEmail());
        if(user1==null){
            HttpSession session = request.getSession();
            User userinfo = (User)session.getAttribute("userinfo");
            user.setId(userinfo.getId());
            int i = userMapper.updateByPrimaryKeySelective(user);
            if(i>0){
                User user2 = userMapper.selectByPrimaryKey(user.getId());
                session.setAttribute("userinfo",user2);
                regRespObj.setStatus(0);
                regRespObj.setAction("/user/set");
            }else {
                regRespObj.setStatus(1);
                regRespObj.setMsg("数据库异常，联系管理员");
            }
        }else {
            regRespObj.setStatus(1);
            regRespObj.setMsg("修改失败，修改的邮箱已经被注册");
        }
        return regRespObj;
    }
    @RequestMapping("upload")
    @ResponseBody
    public RegRespObj upload(@RequestParam  MultipartFile file,HttpServletRequest request) throws IOException {
        RegRespObj regRespObj = new RegRespObj();
        if(file.getSize()>0){
            String realPath = request.getServletContext().getRealPath("/res/uploadImgs");
            File file1 = new File(realPath);
            if(!file1.exists()){
                file1.mkdirs();
            }
            UUID uuid = UUID.randomUUID();
            File file2 = new File(realPath+File.separator+uuid+file.getOriginalFilename());
            file.transferTo(file2);
            HttpSession session = request.getSession();
            User userinfo = (User)session.getAttribute("userinfo");
            userinfo.setPicPath(uuid+file.getOriginalFilename());
            userMapper.updateByPrimaryKeySelective(userinfo);
            session.setAttribute("userinfo",userinfo);
            regRespObj.setStatus(0);
        }
        return regRespObj;
    }
    @RequestMapping("repass")
    @ResponseBody
    public RegRespObj repass(String nowpass,String pass,HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        String pwd = MD5Utils.getPwd(pass);
        userinfo.setPasswd(pwd);
        userMapper.updateByPrimaryKeySelective(userinfo);
        regRespObj.setStatus(0);
        regRespObj.setAction("/user/set");
        return regRespObj;
    }
    @RequestMapping("checkNowpass/{id}")
    @ResponseBody
    public RegRespObj checkNowpass(@PathVariable Integer id,HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        String pwd = MD5Utils.getPwd(id.toString());
        if(pwd.equals(userinfo.getPasswd())){
            regRespObj.setMsg("当前密码正确");
        }else {
            regRespObj.setMsg("当前密码不正确");
        }
        return regRespObj;
    }
    @RequestMapping("gohome")
    public ModelAndView gohome(HttpServletRequest request) throws ParseException {
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        ModelAndView modelAndView = new ModelAndView();
        List<Map<String, Object>> maps = topicMapper.selectByUserID(userinfo.getId());
        if(maps.get(0).get("create_time")!=null){
            for(Map<String, Object> m:maps){
                Date create_time = (Date) m.get("create_time");
                String stringDate = StringDate.getStringDate(create_time);
                m.put("create_time",stringDate);
            }
        }
        modelAndView.setViewName("/user/home");
        modelAndView.addObject("list",maps);

        List<Map<String, Object>> maps1 = commentMapper.selectByUseridAndTopicid(userinfo.getId());
        for(Map<String, Object> m1:maps1){
            Date create_time = (Date) m1.get("comment_time");
            String stringDate = StringDate.getStringDate(create_time);
            m1.put("comment_time",stringDate);
        }
        modelAndView.addObject("list1",maps1);
        return modelAndView;
    }
    @RequestMapping("getFenye")
    @ResponseBody
    public Map<String,Object> getFenye(HttpServletRequest request,PageInfo pageInfo) throws ParseException {

        int total = commentMapper.getTotal(pageInfo.getUserId());

        List<Map<String, Object>> pageInfo1 = commentMapper.getPageInfo(pageInfo);
        for(Map<String, Object> m:pageInfo1){
            Date comment_time = (Date) m.get("comment_time");
            String stringDate = StringDate.getStringDate(comment_time);
            m.put("comment_time",stringDate);
        }
        Map<String,Object> map = new HashMap<>();
        map.put("total",total);
        map.put("datas",pageInfo1);
        return map;
    }
    @RequestMapping("goUserIndex")
    public ModelAndView goUserIndex(HttpServletRequest request) throws ParseException {
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        List<Map<String, Object>> maps = topicMapper.selectByUserID(userinfo.getId());
        int size = maps.size();
        if(maps.get(0).get("title")==null){
            size=0;
        }
        modelAndView.setViewName("/user/index");
        modelAndView.addObject("list",maps);
        modelAndView.addObject("size",size);

        List<Map<String, Object>> maps1 = userCollectTopicMapper.selectByUseridAndTopicid(userinfo.getId());
        int size1 = maps1.size();
        for(Map<String, Object> m:maps1){
            Date create_time = (Date) m.get("collect_time");
            String stringDate = StringDate.getStringDate(create_time);
            m.put("collect_time",stringDate);
        }
        modelAndView.addObject("list1",maps1);
        modelAndView.addObject("size1",size1);
        return modelAndView;
    }
    @RequestMapping("goMessage")
    public ModelAndView goMessage(HttpServletRequest request) throws ParseException {
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        List<Map<String, Object>> maps = commentMapper.selectForMessage(userinfo.getId());
        for(Map<String, Object> m:maps){
            Date create_time = (Date) m.get("comment_time");
            String stringDate = StringDate.getStringDate(create_time);
            m.put("comment_time",stringDate);
        }
        modelAndView.setViewName("/user/message");
        modelAndView.addObject("list",maps);
        return modelAndView;
    }
}
