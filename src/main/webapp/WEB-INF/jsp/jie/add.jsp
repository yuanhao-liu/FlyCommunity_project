<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/10
  Time: 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>发表问题 编辑问题 公用</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/global.css">
    <script src="${pageContext.request.contextPath}/res/jquery-3.3.1.js"></script>
    <script>
        $(function () {
            $("#L_vercode").focus(function () {
                var L_vercode=$("#L_vercode").val();
                if(L_vercode!=2){
                    $("#btnFabu").addClass("layui-btn-disabled");
                }else {
                    $("#btnFabu").removeClass("layui-btn-disabled");
                }
            }).blur(function () {
                $("#L_vercode").trigger("focus");
            })
        })
    </script>
</head>
<body>

<%@include file="../common/header.jsp"%>

<div class="layui-container fly-marginTop">
    <div class="fly-panel" pad20 style="padding-top: 5px;">
        <!--<div class="fly-none">没有权限</div>-->
        <div class="layui-form layui-form-pane">
            <div class="layui-tab layui-tab-brief" lay-filter="user">
                <ul class="layui-tab-title">
                    <li class="layui-this"><c:choose>
                        <c:when test="${list==null}">发表新帖</c:when>
                        <c:otherwise>编辑帖子</c:otherwise>
                    </c:choose></li>
                </ul>
                <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                    <div class="layui-tab-item layui-show">
                        <form action="/jie/doadd" method="post">
                            <div class="layui-row layui-col-space15 layui-form-item">
                                <div class="layui-col-md3">
                                    <label class="layui-form-label">所在专栏</label>
                                    <div class="layui-input-block">
                                        <select lay-verify="required" name="topicCategoryId" lay-filter="column"  <c:if test="${list!=null}">disabled</c:if>>
                                            <option></option>
                                            <option value="1" <c:if test="${list.topicCategoryId==1}">selected</c:if>>提问</option>
                                            <option value="2" <c:if test="${list.topicCategoryId==2}">selected</c:if>>分享</option>
                                            <option value="3" <c:if test="${list.topicCategoryId==3}">selected</c:if>>讨论</option>
                                            <option value="4" <c:if test="${list.topicCategoryId==4}">selected</c:if>>建议</option>
                                            <option value="5" <c:if test="${list.topicCategoryId==5}">selected</c:if>>公告</option>
                                            <option value="6" <c:if test="${list.topicCategoryId==6}">selected</c:if>>动态</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-col-md9">
                                    <label for="L_title" class="layui-form-label">标题</label>
                                    <div class="layui-input-block">
                                        <c:choose>
                                            <c:when test="${list==null}"><input type="text" id="L_title" name="title" required lay-verify="required" autocomplete="off" class="layui-input"></c:when>
                                            <c:otherwise>
                                                <input type="text" id="L_title" name="title" required lay-verify="required" autocomplete="off" class="layui-input" value="${list.title}">
                                                <input type="hidden" name="id" value="${list.id}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row layui-col-space15 layui-form-item layui-hide" id="LAY_quiz">
                                <div class="layui-col-md3">
                                    <label class="layui-form-label">所属产品</label>
                                    <div class="layui-input-block">
                                        <select name="project">
                                            <option></option>
                                            <option value="layui">layui</option>
                                            <option value="独立版layer">独立版layer</option>
                                            <option value="独立版layDate">独立版layDate</option>
                                            <option value="LayIM">LayIM</option>
                                            <option value="Fly社区模板">Fly社区模板</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-col-md3">
                                    <label class="layui-form-label" for="L_version">版本号</label>
                                    <div class="layui-input-block">
                                        <input type="text" id="L_version" value="" name="version" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md6">
                                    <label class="layui-form-label" for="L_browser">浏览器</label>
                                    <div class="layui-input-block">
                                        <input type="text" id="L_browser"  value="" name="browser" placeholder="浏览器名称及版本，如：IE 11" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item layui-form-text">
                                <div class="layui-input-block">
                                    <c:choose>
                                        <c:when test="${list==null}">
                                            <textarea id="L_content" name="content" required lay-verify="required" placeholder="详细描述" class="layui-textarea fly-editor" style="height: 260px;"></textarea>
                                        </c:when>
                                        <c:otherwise>
                                            <textarea id="L_content" name="content" required lay-verify="required" placeholder="详细描述" class="layui-textarea fly-editor" style="height: 260px;">${list.content}</textarea>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">悬赏飞吻</label>
                                    <div class="layui-input-inline" style="width: 190px;">
                                        <select name="kissNum" <c:if test="${list!=null}">disabled</c:if>>
                                            <option value="20" <c:if test="${list.kissNum==20}">selected</c:if>>20</option>
                                            <option value="30" <c:if test="${list.kissNum==30}">selected</c:if>>30</option>
                                            <option value="50" <c:if test="${list.kissNum==50}">selected</c:if>>50</option>
                                            <option value="60" <c:if test="${list.kissNum==60}">selected</c:if>>60</option>
                                            <option value="80" <c:if test="${list.kissNum==80}">selected</c:if>>80</option>
                                        </select>
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">发表后无法更改飞吻</div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="L_vercode" class="layui-form-label">人类验证</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="L_vercode" name="vercode" required lay-verify="required" placeholder="请回答后面的问题" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-form-mid">
                                    <span style="color: #c00;">1+1=?</span>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button class="layui-btn" lay-filter="*" lay-submit id="btnFabu">立即发布</button>
                            </div>
                        </form>
                    </div>
                </div>
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
    }).use('fly');
</script>

</body>
</html>
