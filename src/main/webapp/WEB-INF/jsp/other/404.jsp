<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/13
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>404 - Fly社区</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/global.css">
</head>
<body>

<%@include file="../common/header.jsp"%>
<div class="layui-hide-xs">
    <div class="fly-panel fly-column">
        <div class="layui-container">
            <ul class="layui-clear">
                <li class="layui-hide-xs"><a href="/">首页</a></li>
                <li class="layui-this"><a href="">提问</a></li>
                <li><a href="">分享<span class="layui-badge-dot"></span></a></li>
                <li><a href="">讨论</a></li>
                <li><a href="">建议</a></li>
                <li><a href="">公告</a></li>
                <li><a href="">动态</a></li>
                <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li>
                <c:choose>
                    <c:when test="${userinfo==null}"></c:when>
                    <c:otherwise><!-- 用户登入后显示 -->
                        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="/user/goUserIndex">我发表的贴</a></li>
                        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="/user/goUserIndex#collection">我收藏的贴</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>

            <div class="fly-column-right layui-hide-xs">
                <span class="fly-search"><i class="layui-icon"></i></span>
                <a href="/jie/add" class="layui-btn">发表新帖</a>
            </div>
            <div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;">
                <a href="/jie/add" class="layui-btn">发表新帖</a>
            </div>
        </div>
    </div>
</div>


<div class="layui-container fly-marginTop">
    <div class="fly-panel">
        <div class="fly-none">
            <h2><i class="iconfont icon-404"></i></h2>
            <p>页面或者数据被<a href="http://fly.layui.com/u/336" target="_blank"> 纸飞机 </a>运到火星了，啥都看不到了…</p>
        </div>
    </div>
</div>

<div class="fly-footer">
    <p><a href="http://fly.layui.com/" target="_blank">Fly社区</a> 2017 &copy; <a href="http://www.layui.com/" target="_blank">layui.com 出品</a></p>
    <p>
        <a href="http://fly.layui.com/jie/3147/" target="_blank">付费计划</a>
        <a href="http://www.layui.com/template/fly/" target="_blank">获取Fly社区模版</a>
        <a href="http://fly.layui.com/jie/2461/" target="_blank">微信公众号</a>
    </p>
</div>

<script src="${pageContext.request.contextPath}/res/layui/layui.js"></script>
<script>
    layui.cache.page = '';
    layui.cache.user = {
        username: '游客'
        ,uid: -1
        ,avatar: '${pageContext.request.contextPath}/res/images/avatar/00.jpg'
        ,experience: 123
        ,sex: '男'
    };
    layui.config({
        version: "3.0.0"
        ,base: '${pageContext.request.contextPath}/res/mods/'
    }).extend({
        fly: 'index'
    }).use('fly');
</script>

</body>
</html>
