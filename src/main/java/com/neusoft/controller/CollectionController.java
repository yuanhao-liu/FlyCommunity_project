package com.neusoft.controller;

import com.neusoft.domain.User;
import com.neusoft.domain.UserCollectTopic;
import com.neusoft.mapper.UserCollectTopicMapper;
import com.neusoft.response.RegRespObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("collection")
public class CollectionController {
    @Autowired
    UserCollectTopicMapper userCollectTopicMapper;
    @RequestMapping("add")
    @ResponseBody
    public RegRespObj collectionAdd(Integer cid, HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        HttpSession session = request.getSession();
        User userinfo = (User) session.getAttribute("userinfo");
        if(userinfo==null){
            regRespObj.setStatus(1);
            regRespObj.setMsg("请先登录");
        }else{
            UserCollectTopic userCollectTopic = new UserCollectTopic();
            userCollectTopic.setCollectTime(new Date());
            userCollectTopic.setUserId(userinfo.getId());
            userCollectTopic.setTopicId(cid);
            userCollectTopicMapper.insertSelective(userCollectTopic);
            regRespObj.setStatus(0);
        }

        return regRespObj;
    }
    @RequestMapping("remove")
    @ResponseBody
    public RegRespObj collectionRemove(Integer cid, HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        HttpSession session = request.getSession();
        User userinfo = (User) session.getAttribute("userinfo");
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userinfo.getId());
        map.put("topicId",cid);
        userCollectTopicMapper.deleteByUserIdAndTopicId(map);
        regRespObj.setStatus(0);
        return regRespObj;
    }
}
