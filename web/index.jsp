<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="entity.User" %>
<%@ page import="dao.UserDao" %>
<%@ page import="dao.DishDao" %>
<%@ page import="entity.Dish" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>咸甜酸辣</title>

    <link rel="stylesheet" href="css/ly.css">

    <script>
        window.onload = function () {
            var oDiv = document.getElementById('chedanba');
            var aBtn = oDiv.getElementsByTagName('button');
            var aDiv = document.getElementsByName('seven');

            for (var i = 0; i < aBtn.length; i++) {
                aBtn[i].index = i;
                aBtn[i].onmouseover = function () {
                    for (var i = 0; i < aBtn.length; i++) {

                        aDiv[i].style.display = 'none';
                    }

                    //alert(this.index);
                    aDiv[this.index].style.display = 'block';
                };
            }
        };
    </script>
    <script src="js/search.js"></script>
</head>

<%
    UserDao userDao = new UserDao();
    DishDao dishDao = new DishDao();
%>
<jsp:useBean id="user" class="entity.User" scope="session"></jsp:useBean>
<body>
<!--导航栏-->
<div class="aheader" id="id0">
    <div class="lheader">
    </div>
    <div class="header">
        <nav class="nav nav3" style="padding-top:20px">
            <ul>
                <li>
                    <a href="javascript:void(0);">首页</a>

                </li>
                <li>
                    <a href="list.jsp">总览</a>

                </li>
                <li>
                    <a href="javascript:void(0);">监督</a>

                </li>
                <li>
                    <a href="javascript:void(0);">客服</a>

                </li>
                <li>
                    <a href="javascript:void(0);">餐厅评价</a>
                </li>
            </ul>
        </nav>

    </div>
    <div class="rheader">
        <center>
            <nav class="nav nav3" style="padding-top:20px">
                <ul>
                    <li>
                        <%
                            if (user.getName() != null) {
                        %>
                        <a href="javascript:void(0);">
                            <span style="white-space: nowrap;"><%=user.getName()%>,您好！
                            </span></a>
                        <ul>
                            <li><a href="userinfo.jsp">个人中心</a></li>
                            <%
                                if (user.getRight() == 2) {

                            %>
                            <li><a href="manager.jsp">菜品管理</a></li>
                            <%

                                }
                            %>
                            <li><a href="servlet/LogOffServlet">注销登录</a></li>
                        </ul>
                        <%
                        } else {
                        %>
                        <a href="login.html">登录！</a>
                        <%
                            }
                        %>
                    </li>
                </ul>
            </nav>

        </center>
    </div>
</div>


<!--搜索-->
<div style="height: 400px;float: left;width: 100%">
    <div class="search-area-wrapper">
        <div class="search-area container">
            <h3 class="search-header">菜品搜索！</h3>
            <p class="search-tag-line">现支持搜菜名和餐厅哦！赶快试试吧！</p>
            <form id="search-form" class="search-form clearfix" method="post" action="servlet/SearchServlet"
                  autocomplete="off"
            >
                <input class="search-term required" style="height:50px;" type="text" id="keyword" name="keyword"
                       placeholder="请搜索你想要的菜"
                       title="* Please enter a search term!"
                       onblur="keywordBlur()" onfocus="getMoreContents()" onkeyup="getMoreContents()"/>
                <input class="search-btn" style="height:50px;" type="submit" value="搜索"/>
                <div id="search-error-container"></div>
                <div id="popDiv">
                    <table id="content-table" bgcolor="#FFFAFA" border="0" cellspacing="0" cellpadding="0">
                        <tbody id="content_table_body">
                        <!-- 动态查询出来的数据显示在这里 -->
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
    </div>
</div>


<!--选项栏-->
<div style="width:100%">
    <div class="col-13"></div>
    <div class="col-3" id="chedanba">
        <br>
        <br>
        <table>


            <tr>
                <button class="button" style="vertical-align:middle"><span>咸 </span></button>
            </tr>
            <tr>
                <button class="button" style="vertical-align:middle"><span>甜 </span></button>
            </tr>
            <tr>
                <button class="button" style="vertical-align:middle"><span>酸 </span></button>
            </tr>
            <tr>
                <button class="button" style="vertical-align:middle"><span>辣 </span></button>
            </tr>


        </table>
    </div>

    <div class="col" style="display:block;">
        <div id="div1">


            <a href="#">
                <div class="gg" name="seven"
                     style="display:block; background:url(images/1.jpg);background-size: 100% 100%;height:280px;">
                </div>
            </a>

            <div class="gg" style="display:none; background:url(images/2.jpg);background-size: 100% 100%; height:280px;"
                 name="seven">
            </div>
            <div class="gg" style="display:none; background:url(images/3.jpg);background-size: 100% 100%;height:280px; "
                 name="seven">
            </div>
            <div class="gg" style="display:none; background:url(images/1.jpg);background-size: 100% 100%;height:280px; "
                 name="seven">
            </div>
        </div>
    </div>
</div>

<!--图片区域-->

<div class="tamiddle">


    <div class="zhanshi" style="display:block;" id="id1">
        <center>
            <table width=700 height=600 align=center>
                <hr width=600 height=3 color=white>
                <font size=6px color=white>咸</font>
                <hr width=600 height=3 color=white>

                <%
                    //循环开始
                    ArrayList<Dish> saltyList = dishDao.getOrderByTaste("salty");
                    if (saltyList != null && saltyList.size() > 0) {
                        for (int i = 0; i < saltyList.size(); i += 4) {
                %>
                <tr>
                    <br>
                    <%
                        for (int k = i; k < i + 4 && k < saltyList.size(); k++) {
                            Dish dish=saltyList.get(k);
                    %>
                    <td align=center><a href="details.jsp?id=<%=dish.getId()%>">
                        <div class="circledm" style="background:url(../img/<%=dish.getImgurl()%>);background-size: 100% 100%">
                            <br>咸度：<%=dish.getSalty()%>分
                        </div>
                    </a></td>
                    <%
                        }
                    %>
                </tr>
                <%
                            //循环结束
                        }
                    }
                %>
            </table>
        </center>

    </div>


    <div class="zhanshi" style="display:block;" id="id2">
        <center>
            <table width=700 height=600 align=center>
                <hr width=600 height=3 color=white>
                <font size=6px color=white>辣</font>
                <hr width=600 height=3 color=white>
                <%
                    //循环开始
                    ArrayList<Dish> hotList = dishDao.getOrderByTaste("hot");
                    if (hotList != null && hotList.size() > 0) {
                        for (int i = 0; i < hotList.size(); i += 4) {
                %>
                <tr>
                    <br>
                    <%
                        for (int k = i; k < i + 4 && k < hotList.size(); k++) {
                            Dish dish=hotList.get(k);
                    %>
                    <td align=center><a href="details.jsp?id=<%=dish.getId()%>">
                        <div class="dmsc" style="background:url(../img/<%=dish.getImgurl()%>);background-size: 100% 100%">
                            <br>辣度：<%=dish.getHot()%>分
                        </div>
                    </a></td>
                    <%
                        }
                    %>
                </tr>
                <%
                            //循环结束
                        }
                    }
                %>

            </table>
        </center>

    </div>


    <div class="zhanshi" style="display:block;" id="id3">
        <center>
            <table width=700 height=600 align=center>
                <hr width=600 height=3 color=white>
                <font size=6px color=white>甜</font>
                <hr width=600 height=3 color=white>
                <%
                    //循环开始
                    ArrayList<Dish> sweetList = dishDao.getOrderByTaste("sweet");
                    if (hotList != null && sweetList.size() > 0) {
                        for (int i = 0; i < sweetList.size(); i += 4) {
                %>
                <tr>
                    <br>
                    <%
                        for (int k = i; k < i + 4 && k < sweetList.size(); k++) {
                            Dish dish=sweetList.get(k);
                    %>
                    <td align=center><a href="details.jsp?id=<%=dish.getId()%>">
                        <div class="tz" style="background:url(../img/<%=dish.getImgurl()%>);background-size: 100% 100%">
                            <br>甜度：<%=dish.getHot()%>分
                        </div>
                    </a></td>
                    <%
                        }
                    %>
                </tr>
                <%
                            //循环结束
                        }
                    }
                %>
            </table>
        </center>

    </div>


</div>


<!--论坛区域-->



<div class="footer">
    <div class="infooter"><a href="#">
        <center style="color:white;">网站介绍</center>
    </a></div>
    <div class="infooter"><a href="#">
        <center style="color:white;">合作伙伴</center>
    </a></div>
    <div class="infooter"><a href="#">
        <center style="color:white;">联系客服</center>
    </a></div>
</div>
<div class="guding">
    <div class="container1" id="xxkdiv">


        <div class="link1"><a href="#id0"></a><a href="#id0">
            <div class="text">搜索查询</div>
        </a>
        </div>


        <div class="link1"><a href="#id1">
            <div class="text">咸味榜</div>
        </a>
        </div>


        <div class="link1"><a href="#id2">
            <div class="text">辣味榜</div>
        </a>
        </div>


        <div class="link1"><a href="#id3">
            <div class="text">甜味榜</div>
        </a>
        </div>


    </div>


</div>
</body>


</html>
