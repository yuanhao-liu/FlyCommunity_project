package com.neusoft.controller;

import com.neusoft.domain.Comment;
import com.neusoft.domain.Topic;
import com.neusoft.domain.User;
import com.neusoft.mapper.CommentMapper;
import com.neusoft.mapper.TopicMapper;
import com.neusoft.mapper.UserCollectTopicMapper;
import com.neusoft.mapper.UserMapper;
import com.neusoft.response.RegRespObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("jie")
public class JieController {
    @Autowired
    TopicMapper topicMapper;
    @Autowired
    UserMapper userMapper;
    @Autowired
    CommentMapper commentMapper;
    @Autowired
    UserCollectTopicMapper userCollectTopicMapper;
    @RequestMapping("add")
    public String add(){
        return "jie/add";
    }
    @RequestMapping("bianjiadd/{id}")
    public ModelAndView bianjiadd(@PathVariable int id){
        ModelAndView modelAndView = new ModelAndView();
        Topic topic = topicMapper.selectByPrimaryKey(id);
        modelAndView.setViewName("jie/add");
        modelAndView.addObject("list",topic);
        return modelAndView;
    }
    @RequestMapping("doadd")
    @ResponseBody
    public RegRespObj doAdd(Topic topic, HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        if(topic.getId()==null){ //发表新帖子
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
        }else{ //编辑帖子
            int i = topicMapper.updateByPrimaryKeySelective(topic);
            regRespObj.setStatus(0);
            regRespObj.setAction("/jie/godetail/"+topic.getId());
        }
        return regRespObj;
    }
    @RequestMapping("gojieindex/{cid}/{typeid}")
    public ModelAndView gojieindex(HttpServletRequest request,@PathVariable int cid,@PathVariable int typeid){
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        modelAndView.addObject("cid",cid);
        modelAndView.addObject("typeid",typeid);
        List<Map<String, Object>> maps = topicMapper.selectForPage();
        modelAndView.setViewName("/jie/index");

        modelAndView.addObject("list",maps);

        List<Topic> topics = topicMapper.selectForReyi();
        modelAndView.addObject("list2",topics);
        return modelAndView;
    }
    @RequestMapping("godetail/{id}")
    public ModelAndView godetail(@PathVariable int id,HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        Topic topic = topicMapper.selectByPrimaryKey(id);
        topic.setViewTimes(topic.getViewTimes()+1);
        topicMapper.updateByPrimaryKeySelective(topic);

        List<Topic> topics = topicMapper.selectForReyi();
        modelAndView.addObject("list2",topics);
        modelAndView.setViewName("/jie/detail");

        Map<String, Object> map = topicMapper.selectByTopicID(id);
        modelAndView.addObject("list",map);

        List<Map<String, Object>> maps = commentMapper.selectForDetail(id);
        modelAndView.addObject("list1",maps);

        if(userinfo!=null){
            Map<String,Object> collectMap=new HashMap<>();
            collectMap.put("userId",userinfo.getId());
            collectMap.put("topicId",id);
            Map<String, Object> stringObjectMap = userCollectTopicMapper.selectForCollect(collectMap);
            modelAndView.addObject("collectMap",stringObjectMap);
        }
        return modelAndView;
    }
    @RequestMapping("reply")
    @ResponseBody
    public RegRespObj reply(Comment comment,HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");

        if(userinfo!=null){
            comment.setCommentTime(new Date());
            comment.setUserId(userinfo.getId());
            Topic topic = topicMapper.selectByPrimaryKey(comment.getTopicId());
            topic.setCommentNum(topic.getCommentNum()+1);
            topicMapper.updateByPrimaryKeySelective(topic);
            int i = commentMapper.insertSelective(comment);
            if(i>0){
                regRespObj.setStatus(0);
                regRespObj.setAction("/jie/godetail/"+comment.getTopicId());
            }
        }else{
            String referer = request.getHeader("Referer");
            session.setAttribute("referer",referer);
            regRespObj.setAction("/user/login");
        }

        return regRespObj;
    }
}
