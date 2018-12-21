<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/10
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>基于 layui 的极简社区页面模版</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/global.css">
</head>
<body>

<%@include file="../common/header.jsp"%>

<div class="fly-panel fly-column">
    <div class="layui-container">
        <ul class="layui-clear" id="fenleibiaoqian">
            <li class="layui-hide-xs layui-this"><a href="/">首页</a></li>
            <li><a href="/jie/gojieindex/1/0">提问</a></li>
            <li><a href="/jie/gojieindex/2/0">分享<span class="layui-badge-dot"></span></a></li>
            <li><a href="/jie/gojieindex/3/0">讨论</a></li>
            <li><a href="/jie/gojieindex/4/0">建议</a></li>
            <li><a href="/jie/gojieindex/5/0">公告</a></li>
            <li><a href="/jie/gojieindex/6/0">动态</a></li>
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

<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="fly-panel" style="margin-bottom: 0;">

                <div class="fly-panel-title fly-filter" id="topic_fenlei">
                    <a href="/jie/gojieindex/${cid}/0" class="layui-this">综合</a>
                    <span class="fly-mid"></span>
                    <a href="/jie/gojieindex/${cid}/1">未结</a>
                    <span class="fly-mid"></span>
                    <a href="/jie/gojieindex/${cid}/2">已结</a>
                    <span class="fly-mid"></span>
                    <a href="/jie/gojieindex/${cid}/3">精华</a>
                </div>

                <ul class="fly-list" id="fenye_data">

                </ul>

                <!-- <div class="fly-none">没有相关数据</div> -->

                <div style="text-align: center" id="fenye_page">

                </div>

            </div>
        </div>
        <div class="layui-col-md4">
            <dl class="fly-panel fly-list-one">
                <dt class="fly-panel-title">本周热议</dt>
                <c:if test="${list2.size()==0}">
                    <!-- 无数据时 -->
                    <div class="fly-none">没有相关数据</div>
                </c:if>
                <c:forEach items="${list2}" var="topic">
                    <dd>
                        <a href="/jie/godetail/${topic.id}">${topic.title}</a>
                        <span><i class="iconfont icon-pinglun1"></i> ${topic.commentNum}</span>
                    </dd>
                </c:forEach>
            </dl>

            <div class="fly-panel">
                <div class="fly-panel-title">
                    这里可作为广告区域
                </div>
                <div class="fly-panel-main">
                    <a href="" target="_blank" class="fly-zanzhu" style="background-color: #393D49;">虚席以待</a>
                </div>
            </div>

            <div class="fly-panel fly-link">
                <h3 class="fly-panel-title">友情链接</h3>
                <dl class="fly-panel-main">
                    <dd><a href="http://www.layui.com/" target="_blank">layui</a><dd>
                    <dd><a href="http://layim.layui.com/" target="_blank">WebIM</a><dd>
                    <dd><a href="http://layer.layui.com/" target="_blank">layer</a><dd>
                    <dd><a href="http://www.layui.com/laydate/" target="_blank">layDate</a><dd>
                    <dd><a href="mailto:xianxin@layui-inc.com?subject=%E7%94%B3%E8%AF%B7Fly%E7%A4%BE%E5%8C%BA%E5%8F%8B%E9%93%BE" class="fly-link">申请友链</a><dd>
                </dl>
            </div>

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
<script id="demo" type="text/html">
    {{# layui.each(d.datas,function(index, item){ }}
    {{# if(item.is_delete==0){  }}
    <li>
        <a href="/goUserHome/{{item.userid}}" class="fly-avatar">
            {{# if(item.pic_path==''){ }}
            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心">
            {{# }else{  }}
            <img src="${pageContext.request.contextPath}/res/uploadImgs/{{item.pic_path}}">
            {{#  }   }}
        </a>
        <h2>
            <a class="layui-badge">{{item.name}}</a>
            <a href="/jie/godetail/{{item.id}}">{{item.title}}</a>
        </h2>
        <div class="fly-list-info">
            <a href="/goUserHome/{{item.userid}}" link>
                <cite>{{item.nickname}}</cite>
                <!--
                <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                <i class="layui-badge fly-badge-vip">VIP3</i>
                -->
            </a>
            <span>{{item.create_time}}</span>

            <span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i> {{item.kiss_num}}</span>
            {{#  if(item.is_end==0){  }}
            <span class="fly-list-nums"></span>
            {{#   }else{   }}
            <span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>
            {{#  }   }}

            <span class="fly-list-nums">
                        <i class="iconfont icon-pinglun1" title="回答"></i> {{item.comment_num}}
                    </span>
        </div>
        <div class="fly-list-badge">
            {{#if(item.is_good==1){}}
            <span class="layui-badge layui-bg-red">精帖</span>
            {{#}}}
        </div>
    </li>
    {{#  }   }}
    {{#  }); }}
</script>
<script>
    function getPagedTopic(pageInfo,jq){
        var $ = jq;
        if(!pageInfo)
        {
            var pageInfo = {};
            pageInfo.pageIndex = 1;
            pageInfo.pageSize = 10;
            pageInfo.cid=${cid};
            pageInfo.typeid=${typeid};
        }

        $.post({
            url:'${pageContext.request.contextPath}/get_paged_topic',
            dataType:'json',
            data:pageInfo,
            success:function (data) {
//                alert(res.topics[0].title);
                //1.渲染分页组件
                layui.laypage.render({
                    elem: 'fenye_page' //注意，这里的 test1 是 ID，不用加 # 号
                    ,limit:pageInfo.pageSize
                    ,curr:pageInfo.pageIndex
                    ,count:data.total//数据总数，从服务端得到
                    ,first:"首页"
                    ,last:"尾页"
                    ,jump:function (obj,fisrt) {
                        if(!fisrt)
                        {
                            pageInfo.pageSize = obj.limit;
                            pageInfo.pageIndex = obj.curr;
                            pageInfo.cid=${cid};
                            pageInfo.typeid=${typeid};
                            getPagedTopic(pageInfo,$);
                        }
                    }
                });
                //2.渲染帖子列表
                var getTpl = demo.innerHTML;
                var view = document.getElementById('fenye_data');

                layui.laytpl(getTpl).render(data, function(html){
                    view.innerHTML = html;
                });
            }
        })
    }
    layui.cache.page = '';
    layui.cache.user = {
        username: '游客'
        ,uid: -1
        ,avatar: '${pageContext.request.contextPath}/res/images/avatar/00.jpg'
        ,experience: 83
        ,sex: '男'
    };
    layui.config({
        version: "3.0.0"
        ,base: '${pageContext.request.contextPath}/res/mods/' //这里实际使用时，建议改成绝对路径
    }).extend({
        fly: 'index'
    }).use(['fly','laypage','laytpl'],function () {
        var jq = layui.jquery;
        var $ = layui.jquery;
        //请求第一页的数据（每页2条）
        getPagedTopic(null,jq);

        $("#topic_fenlei").find("a").eq(${typeid}).addClass('layui-this').siblings().removeClass('layui-this');
        $("#fenleibiaoqian").find("li").eq(${cid}).addClass('layui-this').siblings().removeClass('layui-this');
    });
</script>

</body>
</html>
