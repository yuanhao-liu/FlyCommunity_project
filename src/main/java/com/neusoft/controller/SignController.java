package com.neusoft.controller;

import com.neusoft.domain.User;
import com.neusoft.domain.UserQiandao;
import com.neusoft.mapper.UserMapper;
import com.neusoft.mapper.UserQiandaoMapper;
import com.neusoft.response.RegRespObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
@RequestMapping("sign")
public class SignController {
    @Autowired
    UserQiandaoMapper userQiandaoMapper;
    @Autowired
    UserMapper userMapper;
    @RequestMapping("in")
    @ResponseBody
    public RegRespObj signIn(Integer token, HttpServletRequest request){
        RegRespObj regRespObj = new RegRespObj();
        HttpSession session = request.getSession();
        User userinfo = (User) session.getAttribute("userinfo");

        if(userinfo==null){
            regRespObj.setStatus(1);
            regRespObj.setMsg("请先登录");
        }else{
            UserQiandao userQiandao = userQiandaoMapper.selectByUserID(userinfo.getId());
            if(userQiandao==null){
                UserQiandao userQiandao1 = new UserQiandao();
                userQiandao1.setUserId(userinfo.getId());
                userQiandao1.setCreateTime(new Date());
                userQiandao1.setTotal(1);
                userQiandaoMapper.insertSelective(userQiandao1);

                User user = userMapper.selectByPrimaryKey(userinfo.getId());
                user.setKissNum(user.getKissNum()+5);
                userMapper.updateByPrimaryKeySelective(user);
                regRespObj.setStatus(0);
            }else {
                userQiandao.setTotal(userQiandao.getTotal()+1);
                userQiandao.setCreateTime(new Date());
                userQiandaoMapper.updateByPrimaryKeySelective(userQiandao);

                User user = userMapper.selectByPrimaryKey(userinfo.getId());
                user.setKissNum(user.getKissNum()+5);
                userMapper.updateByPrimaryKeySelective(user);
                regRespObj.setStatus(0);
            }
        }

        return regRespObj;
    }
}
