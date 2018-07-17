<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%@ page import="entity.Dish" %>
<%@ page import="dao.DishDao" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>菜品总览</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" type="text/css" href="css/index_css.css">
    <link rel="stylesheet" href="css/ly.css">
    <style>
        .project-pages li {
            display: inline-block;
        }

        .project-pages a {
            width: 34px;
            height: 34px;
            color: #333333;
            text-align: center;
            line-height: 34px;
            display: block;
            background: #dddddd;
        }

        .project-pages a:hover {
            background: #5cb48e;
            color: white;
        }
        html{
            color: white;
        }
    </style>
</head>

<body>

<jsp:useBean id="user" class="entity.User" scope="session"></jsp:useBean>
<%--导航栏--%>
<div class="aheader" id="id0">
    <div class="lheader">
    </div>
    <div class="header">
        <nav class="nav nav3" style="padding-top:20px">
            <ul>
                <li>
                    <a href="index.jsp">首页</a>

                </li>
                <li>
                    <a href="javascript:void(0);">总览</a>

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
                                if (user.getRight()==2) {

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



<center>
    <table width="750" height="60" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td>

                <!-- 商品循环开始 -->
                <%
                    DishDao dishDao = new DishDao();
                    ArrayList<Dish> list = dishDao.getAllDishes();
                    if (list != null && list.size() > 0) {
                        for (int k = 0; k < list.size(); k += 12) {
                            for (int i = k; i < k + 12 && i < list.size(); i++) {
                                Dish dish = list.get(i);
                %>
                <div class="listdiv dishlog<%=(int)k/12+1%>" style="display: none">
                    <div class="port-2 effect-1">
                        <div class="image-box">
                            <img src="../img/<%=dish.getImgurl()%>" ;alt="Image-1" class="lysrc">
                        </div>
                        <span style="color: wheat"><%=dish.getWname() %></span>
                        <div class="text-desc"
                             style="background:url(../img/<%=dish.getImgurl()%>);background-size: 100% 100%;;height:180px">
                            <center><a href="details.jsp?id=<%=dish.getId()%>" class="cdbtn"><%=dish.getName() %>
                            </a></center>
                            <center><p style="color:#fff9f8;font-size:20px;"><%=dish.getPrice() %>元</p></center>
                        </div>
                    </div>
                </div>
                <!-- 商品循环结束 -->

                <%
                            }
                        }
                    } else {
                        out.print("商品正在上架中......");
                    }
                %>
            </td>
        </tr>
        <tr>
            <div class="project-pages">
                <ul>
                    <li><a href="javascript:void(0);" onclick="goNextReplyPage()">向前</a></li>
                    <li>第 <span id="dishPage">1</span> 页</li>
                    <li><a href="javascript:void(0);" onclick="goPreviousReplyPage()">向后</a></li>
                </ul>
            </div>
        </tr>
    </table>
</center>
</body>

<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>

<%--分页--%>
<script type="text/javascript">
    var dishPage = 1;
    var maxDishPage = parseInt(<%=(int)list.size()/12+1%>);

    function goNextReplyPage() {
        $(".dishlog" + dishPage).fadeOut("fast");
        if (dishPage > 1) {
            dishPage--;
        }
        $("#dishPage").text(dishPage);
        $(".dishlog" + dishPage).fadeIn("fast");
    }

    function goPreviousReplyPage() {
        $(".dishlog" + dishPage).fadeOut("fast");
        if (dishPage < maxDishPage) {
            dishPage++;
        }
        $("#dishPage").text(dishPage);
        $(".dishlog" + dishPage).fadeIn("fast");
    }

    function showCurReplyPage() {
        $(".dishlog" + dishPage).fadeIn("fast");
    }

    $(document).ready(function () {
        showCurReplyPage();
    });
</script>
</html>