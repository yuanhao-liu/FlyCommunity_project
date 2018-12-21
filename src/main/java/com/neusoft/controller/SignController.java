package com.neusoft.controller;

import com.neusoft.Utils.KissUtill;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
    public RegRespObj signIn(Integer token, HttpServletRequest request) throws ParseException {
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
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date createTime = userQiandao.getCreateTime();
                String signTime_format = simpleDateFormat.format(createTime);
                Date signTime_date = simpleDateFormat.parse(signTime_format);//把签到时间去掉具体时间，只留下年月日后变成date类型
                //int signday = createTime.getDate();
                Date date1 = new Date();
                String nowTime_format = simpleDateFormat.format(date1);
                Date nowTime_date = simpleDateFormat.parse(nowTime_format);//把今天的当前时间去掉具体时间，只留下年月日后变成date类型
                //int nowday = date1.getDate();
                long diffDay = (nowTime_date.getTime() - signTime_date.getTime()) / 3600000 / 24;
                if(diffDay==1){
                    userQiandao.setTotal(userQiandao.getTotal()+1);
                    userQiandao.setCreateTime(date1);
                    userQiandaoMapper.updateByPrimaryKeySelective(userQiandao);

                    int kissNum = KissUtill.getKissNum(userQiandao.getTotal());
                    User user = userMapper.selectByPrimaryKey(userinfo.getId());
                    user.setKissNum(user.getKissNum()+kissNum);
                    userMapper.updateByPrimaryKeySelective(user);
                    regRespObj.setStatus(0);
                }else{
                    userQiandao.setTotal(1);
                    userQiandao.setCreateTime(date1);
                    userQiandaoMapper.updateByPrimaryKeySelective(userQiandao);

                    User user = userMapper.selectByPrimaryKey(userinfo.getId());
                    user.setKissNum(user.getKissNum()+5);
                    userMapper.updateByPrimaryKeySelective(user);
                    regRespObj.setStatus(0);
                }
            }
        }
        return regRespObj;
    }
}
