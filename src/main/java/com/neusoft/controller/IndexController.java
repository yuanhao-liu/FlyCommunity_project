package com.neusoft.controller;

import com.neusoft.Utils.StringDate;
import com.neusoft.domain.Topic;
import com.neusoft.domain.User;
import com.neusoft.mapper.CommentMapper;
import com.neusoft.mapper.TopicMapper;
import com.neusoft.mapper.UserMapper;
import com.neusoft.mapper.UserQiandaoMapper;
import com.neusoft.response.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
    @Autowired
    UserMapper userMapper;
    @Autowired
    UserQiandaoMapper userQiandaoMapper;
    @RequestMapping("/")
    public ModelAndView index(HttpServletRequest request)
    {
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        List<Map<String, Object>> maps = topicMapper.selectForIndex();
        modelAndView.setViewName("index");
        modelAndView.addObject("typeid",0);
        modelAndView.addObject("list",maps);

        List<Map<String, Object>> maps2 = topicMapper.selectForZhiding();
        modelAndView.addObject("zhiding",maps2);

        List<Map<String, Object>> maps1 = commentMapper.selectForIndexHuitie();
        modelAndView.addObject("list1",maps1);

        List<Topic> topics = topicMapper.selectForReyi();
        modelAndView.addObject("list2",topics);

        if(userinfo!=null){
            Map<String, Object> qiandaoMap = userQiandaoMapper.selectForQiandao(userinfo.getId());
            modelAndView.addObject("qiandao",qiandaoMap);
        }
        return modelAndView;
    }
    @RequestMapping("goUserHome/{id}")
    public ModelAndView goUserHome(@PathVariable int id) throws ParseException {
        ModelAndView modelAndView = new ModelAndView();
        List<Map<String, Object>> maps = topicMapper.selectByUserID(id);
        if(maps.get(0).get("create_time") !=null){
            for(Map<String, Object> m:maps){
                Date create_time = (Date) m.get("create_time");
                String stringDate = StringDate.getStringDate(create_time);
                m.put("create_time",stringDate);
            }
        }
        modelAndView.setViewName("/user/home");
        modelAndView.addObject("list",maps);

        List<Map<String, Object>> maps1 = commentMapper.selectByUseridAndTopicid(id);
        for(Map<String, Object> m1:maps1){
            Date create_time = (Date) m1.get("comment_time");
            String stringDate = StringDate.getStringDate(create_time);
            m1.put("comment_time",stringDate);
        }
        modelAndView.addObject("list1",maps1);
        return modelAndView;
    }
    @RequestMapping("jump/{name}")
    public ModelAndView dojump(@PathVariable String name) throws ParseException {
        User user = userMapper.selectByNickname(name);
        if(user==null){
            ModelAndView modelAndView = new ModelAndView();
            modelAndView.setViewName("/other/404");
            return modelAndView;
        }else {
            return goUserHome(user.getId());
        }
    }
    @RequestMapping("get_paged_topic")
    @ResponseBody
    public Map<String,Object> getpagedtopic(PageInfo pageInfo){
        Map<String,Object> map=new HashMap<>();
        /*if(pageInfo.getCid()==0){
            int totalCount = topicMapper.getTotalCount();
            List<Map<String, Object>> maps = topicMapper.selectForFenye(pageInfo);
            for(Map<String, Object> m:maps){
                Date create_time = (Date) m.get("create_time");
                String stringDate = StringDate.getStringDate(create_time);
                m.put("create_time",stringDate);
            }
            map.put("total",totalCount);
            map.put("datas",maps);
        }else {
            int fenleiCount = topicMapper.getFenleiCount(pageInfo.getCid());
            List<Map<String, Object>> maps = topicMapper.selectForFenlei(pageInfo);
            for(Map<String, Object> m:maps){
                Date create_time = (Date) m.get("create_time");
                String stringDate = StringDate.getStringDate(create_time);
                m.put("create_time",stringDate);
            }
            map.put("total",fenleiCount);
            map.put("datas",maps);
        }*/
        int totalCount = topicMapper.getTotalCount(pageInfo);
        List<Map<String, Object>> maps = topicMapper.selectForFenye(pageInfo);
        for(Map<String, Object> m:maps){
            Date create_time = (Date) m.get("create_time");
            String stringDate = StringDate.getStringDate(create_time);
            m.put("create_time",stringDate);
        }
        map.put("total",totalCount);
        map.put("datas",maps);
        return map;
    }
}
