<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/10
  Time: 12:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Fly Template v3.0，基于 layui 的极简社区页面模版</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/global.css">
    <script src="${pageContext.request.contextPath}/res/jquery-3.3.1.js"></script>
    <script>
        $(function () {
           var x=$("#jieda").find("i[title=最佳答案]").length;
           if(x>0){
               $("span[type=accept]").hide();
           }
        })
    </script>
</head>
<body>

<%@include file="../common/header.jsp"%>

<div class="fly-panel fly-column">
    <div class="layui-container">
        <ul class="layui-clear">
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
        <div class="layui-col-md8 content detail">
            <div class="fly-panel detail-box">
                <h1>${list.title}</h1>
                <div class="fly-detail-info">
                    <!-- <span class="layui-badge">审核中</span> -->
                    <span class="layui-badge layui-bg-green fly-detail-column">${list.name}</span>
                    <c:choose>
                        <c:when test="${list.is_end==0}"><span class="layui-badge" style="background-color: #999;">未结</span></c:when>
                        <c:otherwise><span class="layui-badge" style="background-color: #5FB878;">已结</span></c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${list.is_top==0}"></c:when>
                        <c:otherwise><span class="layui-badge layui-bg-black">置顶</span></c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${list.is_good==0}"></c:when>
                        <c:otherwise><span class="layui-badge layui-bg-red">精帖</span></c:otherwise>
                    </c:choose>
                    <div class="fly-admin-box" data-id="${list.id}">
                        <c:if test="${userinfo != null}">
                            <c:if test="${userinfo.id == list.userid}">
                                <span class="layui-btn layui-btn-xs jie-admin" type="del">删除</span>
                            </c:if>
                        </c:if>

                        <c:if test="${userinfo.id==1}">
                            <span class="layui-btn layui-btn-xs jie-admin" type="del">删除</span>
                            <c:choose>
                                <c:when test="${list.is_top==0}">
                                    <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="1">置顶</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="0" style="background-color:#ccc;">取消置顶</span>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${list.is_good==0}">
                                    <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1">加精</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="0" style="background-color:#ccc;">取消加精</span>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>
                    <span class="fly-list-nums"> 
            <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i> ${list.comment_num}</a>
            <i class="iconfont" title="人气">&#xe60b;</i> ${list.view_times}
          </span>
                </div>
                <div class="detail-about">
                    <a class="fly-avatar" href="/goUserHome/${list.userid}">
                        <c:choose>
                            <c:when test="${list.pic_path==''}"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心"></c:when>
                            <c:otherwise><img src="${pageContext.request.contextPath}/res/uploadImgs/${list.pic_path}"></c:otherwise>
                        </c:choose>
                    </a>
                    <div class="fly-detail-user">
                        <a href="/goUserHome/${list.userid}" class="fly-link">
                            <cite>${list.nickname}</cite>
                            <i class="iconfont icon-renzheng" title="认证信息：{{ rows.user.approve }}"></i>
                            <i class="layui-badge fly-badge-vip">VIP${list.vip_grade}</i>
                        </a>
                        <span><fmt:formatDate value="${list.create_time}" pattern="yyyy-MM-dd"/></span>
                    </div>
                    <div class="detail-hits" id="LAY_jieAdmin" data-id="${list.id}">
                        <span style="padding-right: 10px; color: #FF7200">悬赏：${list.kiss_num}飞吻</span>
                        <c:if test="${userinfo != null}">
                            <c:if test="${userinfo.id == list.userid and list.is_end==0}">
                                <span class="layui-btn layui-btn-xs jie-admin" type="edit"><a href="/jie/bianjiadd/${list.id}">编辑此贴</a></span>
                            </c:if>
                        </c:if>
                        <c:if test="${userinfo!=null and userinfo.id!=list.userid}">
                            <c:choose>
                                <c:when test="${collectMap==null}">
                                    <span class="layui-btn layui-btn-xs jie-admin" type="collect" data-type="add">收藏</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="layui-btn layui-btn-xs jie-admin layui-btn-danger" type="collect" data-type="remove">取消收藏</span>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>
                </div>
                <div class="detail-body photos">
                    ${list.content}
                </div>
            </div>

            <div class="fly-panel detail-box" id="flyReply">
                <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
                    <legend>回帖</legend>
                </fieldset>

                <ul class="jieda" id="jieda">
                    <c:if test="${list1.size()==0}">
                        <!-- 无数据时 -->
                        <li class="fly-none">消灭零回复</li>
                    </c:if>
                    <c:forEach items="${list1}" var="map1" varStatus="status">
                        <li data-id="${map1.id}" class="jieda-daan">
                            <a name="item-1111111111"></a>
                            <div class="detail-about detail-about-reply">
                                <a class="fly-avatar" href="/goUserHome/${map1.user_id}">
                                    <c:choose>
                                        <c:when test="${map1.pic_path==''}"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心"></c:when>
                                        <c:otherwise><img src="${pageContext.request.contextPath}/res/uploadImgs/${map1.pic_path}"></c:otherwise>
                                    </c:choose>
                                </a>
                                <div class="fly-detail-user">
                                    <a href="/goUserHome/${map1.user_id}" class="fly-link">
                                        <cite>${map1.nickname}</cite>
                                        <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                                        <i class="layui-badge fly-badge-vip">VIP${map1.vip_grade}</i>
                                    </a>
                                        <c:if test="${map1.user_id==map1.userid}">
                                            <span>(楼主)</span>
                                        </c:if>
                                    <!--
                                    <span style="color:#5FB878">(管理员)</span>
                                    <span style="color:#FF9E3F">（社区之光）</span>
                                    <span style="color:#999">（该号已被封）</span>
                                    -->
                                </div>

                                <div class="detail-hits">
                                    <span><fmt:formatDate value="${map1.comment_time}" pattern="yyyy-MM-dd"/></span>
                                </div>
                                <c:if test="${map1.is_choose==1}">
                                    <i class="iconfont icon-caina" title="最佳答案"></i>
                                </c:if>
                            </div>
                            <div class="detail-body jieda-body photos">
                                ${map1.comment_content}
                            </div>
                            <div class="jieda-reply">
              <span class="jieda-zan zanok" type="zan">
                <i class="iconfont icon-zan"></i>
                <em>${map1.like_num}</em>
              </span>
                                <span type="reply">
                <i class="iconfont icon-svgmoban53"></i>
                回复
              </span>
                                <div class="jieda-admin">
                                    <%--<span type="edit">编辑</span>
                                    <span type="del">删除</span>--%>
                                    <c:if test="${map1.is_choose==0}">
                                        <c:if test="${userinfo.id==map1.userid and map1.userid!=map1.user_id}">
                                            <span class="jieda-accept" type="accept">采纳</span>
                                        </c:if>
                                    </c:if>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>

                <div class="layui-form layui-form-pane">
                    <form action="/jie/reply" method="post">
                        <div class="layui-form-item layui-form-text">
                            <a name="comment"></a>
                            <div class="layui-input-block">
                                <textarea id="L_content" name="commentContent" required lay-verify="required" placeholder="请输入内容"  class="layui-textarea fly-editor" style="height: 150px;"></textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <input type="hidden" name="topicId" value="${list.id}">
                            <button class="layui-btn" lay-filter="*" lay-submit>提交回复</button>
                        </div>
                    </form>
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
                    <a href="http://layim.layui.com/?from=fly" target="_blank" class="fly-zanzhu" time-limit="2017.09.25-2099.01.01" style="background-color: #5FB878;">LayIM 3.0 - layui 旗舰之作</a>
                </div>
            </div>

            <div class="fly-panel" style="padding: 20px 0; text-align: center;">
                <img src="${pageContext.request.contextPath}/res/images/weixin.jpg" style="max-width: 100%;" alt="layui">
                <p style="position: relative; color: #666;">微信扫码关注 layui 公众号</p>
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
<script>
        layui.cache.page = 'jie';
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
    }).use(['fly', 'face'], function(){
        var $ = layui.$
            ,fly = layui.fly;
        //如果你是采用模版自带的编辑器，你需要开启以下语句来解析。
        $('.detail-body').each(function(){
          var othis = $(this), html = othis.html();
          othis.html(fly.content(html));
        });
    });
</script>

</body>
</html>
