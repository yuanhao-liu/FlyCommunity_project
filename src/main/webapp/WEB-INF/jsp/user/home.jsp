<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/7
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户主页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/global.css">
    <script src="${pageContext.request.contextPath}/res/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/res/layui/layui.all.js"></script>
    <script>
        function getPageInfo(pageInfo){
            if(!pageInfo){
                pageInfo={};
                pageInfo.pageIndex=1;
                pageInfo.pageSize=5;
                pageInfo.userId=${list1[0].user_id};
            }

            $.post({
                url:"${pageContext.request.contextPath}/user/getFenye",
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
                                    getPageInfo(pageInfo);
                                }
                            }
                        });

                    var getTpl = demo.innerHTML;
                    var view = document.getElementById('fenye_data');

                    layui.laytpl(getTpl).render(data, function(html){
                        view.innerHTML = html;
                    });
                    var $ = layui.$;
                    var fly = layui.fly;
                    //如果你是采用模版自带的编辑器，你需要开启以下语句来解析。
                    $('.home-dacontent').each(function(){
                        var othis = $(this), html = othis.html();
                        othis.html(fly.content(html));
                    });
                }
            });
        }
    </script>
    <script id="demo" type="text/html">
        <ul class="home-jieda">
            {{# layui.each(d.datas,function(index, item){ }}
            <li>
                <p>
                    <span>{{item.comment_time}}</span>
                    在<a href="/jie/godetail/{{item.topic_id}}" target="_blank">{{item.title}}</a>中回答：
                </p>
                <div class="home-dacontent">
                    {{item.comment_content}}
                </div>
            </li>
            {{#  }); }}
        </ul>
    </script>
</head>
<body style="margin-top: 65px;">
<%@include file="../common/header.jsp"%>
<div class="fly-home fly-panel" >
    <c:choose>
        <c:when test="${list[0].pic_path==''}">
            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心">
        </c:when>
        <c:otherwise>
            <img src="${pageContext.request.contextPath}/res/uploadImgs/${list[0].pic_path}">
        </c:otherwise>
    </c:choose>

    <i class="iconfont icon-renzheng" title="Fly社区认证"></i>
    <h1>
        ${list[0].nickname}
        <c:choose>
            <c:when test="${list[0].sex == 0}"><i class="iconfont icon-nan"></i></c:when>
            <c:otherwise><i class="iconfont icon-nv"></i></c:otherwise>
        </c:choose>
        <i class="layui-badge fly-badge-vip">VIP${list[0].vip_grade}</i>
        <!--
        <span style="color:#c00;">（管理员）</span>
        <span style="color:#5FB878;">（社区之光）</span>
        <span>（该号已被封）</span>
        -->
    </h1>

    <p style="padding: 10px 0; color: #5FB878;">认证信息：layui 作者</p>

    <p class="fly-home-info">
        <i class="iconfont icon-kiss" title="飞吻"></i><span style="color: #FF7200;">${list[0].kn} 飞吻</span>
        <i class="iconfont icon-shijian"></i><span><fmt:formatDate value="${list[0].join_time}" pattern="yyyy-MM-dd"/> 加入</span>
        <i class="iconfont icon-chengshi"></i><span>来自${list[0].city}</span>
    </p>

    <p class="fly-home-sign">（${list[0].sign}）</p>

    <div class="fly-sns" data-user="">
        <a href="javascript:;" class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend">加为好友</a>
        <a href="javascript:;" class="layui-btn layui-btn-normal fly-imActive" data-type="chat">发起会话</a>
    </div>

</div>

<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6 fly-home-jie">
            <div class="fly-panel">
                <h3 class="fly-panel-title">${list[0].nickname} 最近的提问</h3>
                <ul class="jie-row">
                    <c:choose>
                        <c:when test="${list.size()==0}">
                             <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有发表任何求解</i></div>
                        </c:when>
                        <c:when test="${list[0].title == null}">
                             <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有发表任何求解</i></div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${list}" var="map">
                                <li>
                                    <c:if test="${map.is_good==1}">
                                        <span class="fly-jing">精</span>
                                    </c:if>
                                    <a href="/jie/godetail/${map.id}" class="jie-title">${map.title}</a>
                                    <i>${map.create_time}</i>
                                    <em class="layui-hide-xs">${map.view_times}阅/${map.comment_num}答</em>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>

        <div class="layui-col-md6 fly-home-da">
            <div class="fly-panel">
                <h3 class="fly-panel-title">${list[0].nickname} 最近的回答</h3>
               <%-- <ul class="home-jieda">
                    <c:choose>
                        <c:when test="${list1.size()==0}">
                             <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有回答任何问题</span></div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${list1}" var="map1">
                                <li>
                                    <p>
                                        <span>${map1.comment_time}</span>
                                        在<a href="/jie/godetail/${map1.topic_id}" target="_blank">${map1.title}</a>中回答：
                                    </p>
                                    <div class="home-dacontent">
                                            ${map1.comment_content}
                                    </div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>--%>
                <div id="fenye_data"></div>
                <div id="fenye_page"></div>
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
    }).use(['fly','face'],function () {
        getPageInfo();
        // var $ = layui.$
        //     ,fly = layui.fly;
        // //如果你是采用模版自带的编辑器，你需要开启以下语句来解析。
        // $('.home-dacontent').each(function(){
        //     var othis = $(this), html = othis.html();
        //     othis.html(fly.content(html));
        // });
    });
</script>

</body>
</html>
