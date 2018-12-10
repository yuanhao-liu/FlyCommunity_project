package com.neusoft.controller;

import com.neusoft.domain.Topic;
import com.neusoft.domain.User;
import com.neusoft.mapper.TopicMapper;
import com.neusoft.mapper.UserMapper;
import com.neusoft.response.RegRespObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
@RequestMapping("jie")
public class JieController {
    @Autowired
    TopicMapper topicMapper;
    @Autowired
    UserMapper userMapper;
    @RequestMapping("add")
    public String add(){
        return "jie/add";
    }
    @RequestMapping("doadd")
    @ResponseBody
    public RegRespObj doAdd(Topic topic, HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        topic.setUserid(userinfo.getId());
        topic.setCreateTime(new Date());
        if((userinfo.getKissNum()-topic.getKissNum())>=0){
            int i = topicMapper.insertSelective(topic);
            if(i>0){
                userinfo.setKissNum(userinfo.getKissNum()-topic.getKissNum());
                userMapper.updateByPrimaryKeySelective(userinfo);
                regRespObj.setStatus(0);
                regRespObj.setAction("/");
            }else {
                regRespObj.setStatus(1);
                regRespObj.setMsg("数据库错误，联系管理员");
            }
        }else {
            regRespObj.setStatus(1);
            regRespObj.setMsg("您当前飞吻数不够，无法发帖");
        }

        return regRespObj;
    }
}
