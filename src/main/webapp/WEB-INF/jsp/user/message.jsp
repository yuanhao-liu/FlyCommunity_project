<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/8
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>我的消息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/global.css">
    <script src="${pageContext.request.contextPath}/res/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/res/layui/layui.all.js"></script>
    <script>
        $(function () {
            getPageInfo();
        });

        function getPageInfo(pageInfo){
            if(!pageInfo){
                pageInfo={};
                pageInfo.pageIndex=1;
                pageInfo.pageSize=5;
                pageInfo.userId=${userinfo.id};
                pageInfo.nickname='${userinfo.nickname}';
            }

            $.post({
                url:"${pageContext.request.contextPath}/user/messageFenye",
                data:pageInfo,
                dataType:"json",
                success:function (data) {
                    var laypage = layui.laypage;
                    laypage.render({
                        elem: 'fenye_page' //注意，这里的 test1 是 ID，不用加 # 号
                        ,limit:pageInfo.pageSize
                        ,count:data.total//数据总数，从服务端得到
                        ,curr:pageInfo.pageIndex
                        ,first:"首页"
                        ,last:"尾页"
                        ,jump: function(obj, first){
                            //obj包含了当前分页的所有参数，比如：
//                        console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
//                        console.log(obj.limit); //得到每页显示的条数
                            if(!first)
                            {
                                pageInfo.pageIndex=obj.curr;
                                pageInfo.pageSize=obj.limit;
                                pageInfo.userId=${userinfo.id};
                                pageInfo.nickname='${userinfo.nickname}';
                                getPageInfo(pageInfo);
                            }
                        }
                    });

                    var getTpl = demo.innerHTML;
                    var view = document.getElementById('fenye_data');

                    layui.laytpl(getTpl).render(data, function(html){
                        view.innerHTML = html;
                    });
                }
            });
        }
    </script>
    <script id="demo" type="text/html">
        {{# if(d.datas==''){ }}
        <div class="fly-none">您暂时没有最新消息</div>
        {{# document.getElementById('fenye_page').setAttribute('style','display: none') }}
        {{# }else{ }}
        {{# layui.each(d.datas,function(index, item){  }}
        <li data-id="{{item.id}}">
            <blockquote class="layui-elem-quote">
                <a href="/jump/{{item.nickname}}" target="_blank"><cite>{{item.nickname}}</cite></a>在{{item.name}}<a target="_blank" href="/jie/godetail/{{item.topic_id}}"><cite>{{item.title}}</cite></a><span>中回复了你</span>
            </blockquote>
            <p><span>{{item.comment_time}}</span><a href="javascript:;" class="layui-btn layui-btn-small layui-btn-danger fly-delete">删除</a></p>
        </li>
        {{# });  }}
        {{# } }}
    </script>
</head>
<body>

<%@include file="../common/header.jsp"%>

<div class="layui-container fly-marginTop fly-user-main">
    <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
        <li class="layui-nav-item">
            <a href="/user/gohome">
                <i class="layui-icon">&#xe609;</i>
                我的主页
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="/user/goUserIndex">
                <i class="layui-icon">&#xe612;</i>
                用户中心
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="/user/set">
                <i class="layui-icon">&#xe620;</i>
                基本设置
            </a>
        </li>
        <li class="layui-nav-item layui-this">
            <a href="/user/goMessage">
                <i class="layui-icon">&#xe611;</i>
                我的消息
            </a>
        </li>
    </ul>

    <div class="site-tree-mobile layui-hide">
        <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>

    <div class="site-tree-mobile layui-hide">
        <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>


    <div class="fly-panel fly-panel-user" pad20>
        <div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg" style="margin-top: 15px;">
            <button class="layui-btn layui-btn-danger" id="LAY_delallmsg">清空全部消息</button>
            <div  id="LAY_minemsg" style="margin-top: 10px;">
                <!--<div class="fly-none">您暂时没有最新消息</div>-->
                <ul class="mine-msg" id="fenye_data">
                    <%--<c:choose>
                        <c:when test="${forMessege.size()==0}">
                           <div class="fly-none">您暂时没有最新消息</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${forMessege}" var="forMessege">
                                <li data-id="${forMessege.id}">
                                    <blockquote class="layui-elem-quote">
                                        <a href="/jump/${forMessege.nickname}" target="_blank"><cite>${forMessege.nickname}</cite></a>在${forMessege.name}<a target="_blank" href="/jie/godetail/${forMessege.topic_id}"><cite>${forMessege.title}</cite></a><span>中回复了你</span>
                                    </blockquote>
                                    <p><span>${forMessege.comment_time}</span><a href="javascript:;" class="layui-btn layui-btn-small layui-btn-danger fly-delete">删除</a></p>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>--%>
                </ul>
                <div id="fenye_page" ></div>
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

<script src="${pageContext.request.contextPath}/res/layui/layui.all.js"></script>
<script>
    layui.cache.page = 'user';
    layui.cache.user = {
        username: '游客'
        ,uid: -1
        ,avatar: '${pageContext.request.contextPath}/res/images/avatar/00.jpg'
        ,experience: 83
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
