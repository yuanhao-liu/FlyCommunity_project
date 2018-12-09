package com.neusoft.controller;

import com.neusoft.domain.User;
import com.neusoft.mapper.CommentMapper;
import com.neusoft.mapper.TopicMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/12/6.
 */
@Controller
public class IndexController {
    @Autowired
    TopicMapper topicMapper;
    @Autowired
    CommentMapper commentMapper;
    @RequestMapping("/")
    public ModelAndView index(HttpServletRequest request)
    {
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        List<Map<String, Object>> maps = topicMapper.selectForIndex();
        modelAndView.setViewName("index");
        modelAndView.addObject("list",maps);

        List<Map<String, Object>> maps1 = commentMapper.selectForIndexHuitie();
        modelAndView.addObject("list1",maps1);
        return modelAndView;
    }
    @RequestMapping("goUserHome/{id}")
    public ModelAndView goUserHome(@PathVariable int id) throws ParseException {
        ModelAndView modelAndView = new ModelAndView();
        List<Map<String, Object>> maps = topicMapper.selectByUserID(id);
        for(Map<String, Object> m:maps){
            long now = new Date().getTime();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            long create_time = formatter.parse(m.get("create_time").toString()).getTime();
            long hour= (now-create_time)/1000/60/60;
            m.put("create_time",hour);
        }
        modelAndView.setViewName("/user/home");
        modelAndView.addObject("list",maps);

        List<Map<String, Object>> maps1 = commentMapper.selectByUseridAndTopicid(id);
        for(Map<String, Object> m1:maps1){
            long now1 = new Date().getTime();
            SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            long create_time1 = formatter1.parse(m1.get("comment_time").toString()).getTime();
            long hour1= (now1-create_time1)/1000/60/60;
            m1.put("comment_time",hour1);
        }
        modelAndView.addObject("list1",maps1);
        return modelAndView;
    }
}
