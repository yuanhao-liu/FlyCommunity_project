package com.neusoft.controller;

import com.neusoft.domain.Comment;
import com.neusoft.domain.User;
import com.neusoft.mapper.CommentMapper;
import com.neusoft.response.RegRespObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("message")
public class MessageController {
    @Autowired
    CommentMapper commentMapper;
    @RequestMapping("remove")
    @ResponseBody
    public RegRespObj removeMessage(Integer id, Boolean all, HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        HttpSession session = request.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        if(all ==null){
            Comment comment = commentMapper.selectByPrimaryKey(id);
            comment.setIsMessage(1);
            commentMapper.updateByPrimaryKeySelective(comment);
            regRespObj.setStatus(0);
        }else{
            Map<String,Object> messegeMap=new HashMap<>();
            messegeMap.put("userId",userinfo.getId());
            messegeMap.put("userNickname",userinfo.getNickname());
            List<Map<String, Object>> forMessege = commentMapper.getForMessege(messegeMap);
            for(Map<String, Object> m:forMessege){
                int id1 = (int) m.get("id");
                Comment comment = commentMapper.selectByPrimaryKey(id1);
                comment.setIsMessage(1);
                commentMapper.updateByPrimaryKeySelective(comment);
            }
            regRespObj.setStatus(0);
        }
        return  regRespObj;
    }
}
