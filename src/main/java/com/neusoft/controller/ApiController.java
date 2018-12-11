package com.neusoft.controller;

import com.neusoft.domain.Topic;
import com.neusoft.mapper.TopicMapper;
import com.neusoft.response.RegRespObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("api")
public class ApiController {
    @Autowired
    TopicMapper topicMapper;
    @RequestMapping("jie-delete")
    @ResponseBody
    public RegRespObj jiedelete(int id){
        RegRespObj regRespObj = new RegRespObj();
        Topic topic = topicMapper.selectByPrimaryKey(id);
        topic.setIsDelete(1);
        int i = topicMapper.updateByPrimaryKeySelective(topic);
        regRespObj.setStatus(0);
        return regRespObj;
    }
}
