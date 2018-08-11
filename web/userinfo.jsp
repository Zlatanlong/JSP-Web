<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%@ page import="entity.User" %>
<%@ page import="entity.Reply" %>
<%@ page import="entity.Praise" %>
<%@ page import="dao.*" %>
<%@ page import="entity.Evaluate" %>
<%
    User user = ((User) session.getAttribute("user"));
    UserDao userDao = new UserDao();
    DishDao dishDao = new DishDao();
%>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]> <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>个人信息</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo-style.css">
    <link rel="stylesheet" href="css/ly.css">
    <script src="js/vendor/modernizr-2.6.2.min.js"></script>
    <style>
        img {
            width: 200px;
            height: 200px;
        }
        html{
            color: white;
        }

    </style>
</head>
<body>
<!--[if lt IE 7]>
<p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade
    your browser</a> to improve your experience.</p>
<![endif]-->
<%--导航栏--%>
<div class="top-header"
     style="padding-bottom: 0px;
     padding-top: 0px;
     height: 1px;"
>

</div>

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

<div class="container" id="page-content">
    <div class="row">


        <div class="col-md-9 col-sm-12 content-holder">
            <!-- CONTENT -->
            <div id="menu-container">
                <%--个人信息--%>
                <div id="menu-1" class="homepage home-section text-center">
                    <div class="box-content profile" style="background:url(images/9.jpg);background-size: 100% 100%">
                        <center>
                            <h3 class="widget-title" align=center>个人信息</h3>
                            <%
                                if (user.getName() != null) {
                            %>
                            <p>用户名：<%=user.getName()%>
                            </p><br>
                            <p>ID：<%=user.getId()%>
                            </p><br>
                            <p>性别：<%=user.getSex()%>
                            </p><br>
                            <p>年龄：<%=user.getAge()%>
                            </p><br>
                            <p>学校：<%=userDao.getSchoolName(user)%>
                            </p><br>
                            <p>身份：<%=userDao.getRight(user)%>
                            </p><br>
                            <%
                            } else {
                            %>
                            <p>您没有登录啊！</p>
                            <%
                                }
                            %>
                        </center>
                    </div>
                </div>
                <%--回复历史--%>
                <div id="menu-2" class="content about-section">
                    <div class="box-content" style="background:url(images/9.jpg);background-size: 100% 100%">
                        <h3 class="widget-title">评论历史</h3>
                        <div class="row">
                            <%
                                ReplyDao reDao = new ReplyDao();
                                ArrayList<Reply> replyList = reDao.getRepliesByUname(user.getName());
                                if (replyList != null && replyList.size() > 0) {
                                    for (int k=0;k<replyList.size();k+=9){
                                        for (int i=k;i<k+9 && i<replyList.size();i++) {
                                            Reply reply=replyList.get(i);
                            %>

                            <div class="col-md-4 col-sm-6 col-xs-12 replylog<%=(int)k/9+1%>" style="display: none">
                                <div class="project-item">
                                    <a href="details.jsp?id=<%=reply.getDid()%>">
                                        <img src="../img/<%=dishDao.getDishById(reply.getDid()).getImgurl()%>" alt="">
                                    </a>
                                    <div class="project-hover">
                                        <h4><%=dishDao.getDishById(reply.getDid()).getName()%>
                                        </h4>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            } else {
                            %>
                            <center><p>您还没有评论过菜品，快去评论吧！</p><br>
                                <a href="list.jsp">点击浏览</a></center>
                            <%
                                }
                            %>
                        </div>
                        <div class="project-pages">
                            <ul>
                                <li><a href="#" onclick="goNextReplyPage()">向前</a></li>
                                <li>第 <span id="replyPage">1</span> 页</li>
                                <li><a href="#" onclick="goPreviousReplyPage()">向后</a></li>
                            </ul>
                        </div>

                    </div>

                </div>
                <%--点赞历史--%>
                <div id="menu-3" class="content gallery-section">
                    <div class="box-content" style="background:url(images/9.jpg);background-size: 100% 100%">
                        <h3 class="widget-title">点赞历史</h3>
                        <div class="row">
                            <%
                                PraiseDao prDao = new PraiseDao();
                                ArrayList<Praise> praiseList = prDao.getPraiseByUid(user.getId());
                                if (praiseList != null && praiseList.size() > 0) {
                                    for (int k=0;k<praiseList.size();k+=9){
                                        for (int i=k;i<k+9 && i<praiseList.size();i++) {
                                        Praise praise=praiseList.get(i);
                            %>
                            <div class="col-md-4 col-sm-6 col-xs-12 praiselog<%=(int)k/9+1%>" style="display: none">
                                <div class="project-item">
                                    <hr>
                                    <p>菜品：<a href="details.jsp?id=<%=reDao.getReply(praise.getRid()).getDid()%>">
                                        <%=dishDao.getDishById(reDao.getReply(praise.getRid()).getDid()).getName()%>
                                    </a></p><br>
                                    <p>评论内容：<%= reDao.getReply(praise.getRid()).getText()%>
                                    </p>
                                    <div class="project-hover">
                                        <h4>评论人：<%=reDao.getReply(praise.getRid()).getUname()%>
                                        </h4>
                                    </div>
                                    <hr>
                                </div>
                            </div>
                            <%
                                     }
                                }
                             }else {
                            %>
                            <center><p>您还没有点赞过，快去逛逛吧！</p><br>
                                <a href="list.jsp">点击浏览</a></center>
                            <%
                                }
                            %>
                        </div>
                        <div class="project-pages" style="display: block">
                            <ul>
                                <li><a href="#" onclick="goNextPraisePage()">向前</a></li>
                                <li>第 <span id="praisePage">1</span> 页</li>
                                <li><a href="#" onclick="goPreviousPraisePage()">向后</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <%--评价历史--%>
                <div id="menu-4" class="content contact-section">
                    <div class="box-content" style="background:url(images/9.jpg);background-size: 100% 100%">
                        <h3 class="widget-title">评价历史</h3>
                        <div class="row">
                            <%
                                EvaluateDao evDao = new EvaluateDao();
                                ArrayList<Evaluate> evaluateList = evDao.getEvaluateByUname(user.getName());
                                if (evaluateList != null && evaluateList.size() > 0) {
                                    for (int k=0;k<evaluateList.size();k+=9){
                                        for (int i=k;i<k+9 && i<evaluateList.size();i++) {
                                            Evaluate evaluate=evaluateList.get(i);
                            %>
                            <div class="col-md-4 col-sm-6 col-xs-12 evaluatelog<%=(int)k/9+1%>">
                                <div class="project-item">
                                    <p>菜品：<a href="details.jsp?id=<%=evaluate.getDishid()%>">
                                        <%=dishDao.getDishById(evaluate.getDishid()).getName()%>
                                    </a></p>
                                    <p>评价内容：<br>
                                        咸：<%=evaluate.getSalty()%>分<br>
                                        甜：<%=evaluate.getSweet()%>分<br>
                                        酸：<%=evaluate.getSour()%>分<br>
                                        辣：<%=evaluate.getHot()%>分<br>
                                    </p>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            } else {
                            %>
                            <center><p>您还没有评价过，快去逛逛吧！</p><br>
                                <a href="list.jsp">点击浏览</a></center>
                            <%
                                }
                            %>

                        </div>
                        <div class="project-pages">
                            <ul>
                                <li><a href="#" onclick="goNextEvaluatePage()">向前</a></li>
                                <li>第 <span id="evaluatePage">1</span> 页</li>
                                <li><a href="#" onclick="goPreviousEvaluatePage()">向后</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="col-md-3 hidden-sm">

            <nav id="nav" class="main-navigation hidden-xs hidden-sm">
                <ul class="main-menu">
                    <li>
                        <a class="show-1 active homebutton" href="#"><i class="fa fa-home"></i>用户信息</a>
                    </li>
                    <li>
                        <a class="show-2 aboutbutton" href="#" onclick="showCurReplyPage()"><i class="fa fa-user"></i>回复历史</a>
                    </li>
                    <li>
                        <a class="show-3 projectbutton" href="#" onclick="showCurPraisePage()"><i class="fa fa-camera"></i>点赞历史</a>
                    </li>
                    <li>
                        <a class="show-5 contactbutton" href="#" onclick="showCurEvaluatePage()"><i class="fa fa-envelope"></i>评价历史</a>
                    </li>
                </ul>
            </nav>

        </div>
    </div>
</div>


<script src="js/vendor/jquery-1.10.2.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<!-- templatemo 439 rectangle -->
<%--分页--%>
<script>
    var replyPage=1;
    var praisePage=1;//当前页数
    var evluatePage=1;
    var maxReplyPage=parseInt(<%=(int)replyList.size()/9+1%>);
    var maxPraisePage=parseInt(<%=(int)praiseList.size()/9+1%>);//最大页数
    var maxEvaluatePage=parseInt(<%=(int)evaluateList.size()/9+1%>);
    function goNextReplyPage() {
        $(".replylog"+replyPage).fadeOut("fast");
        if (replyPage>1) {
            replyPage--;
        }
        $("#replyPage").text(replyPage);
        $(".replylog"+replyPage).fadeIn("fast");
    }
    function goPreviousReplyPage() {
        $(".replylog"+replyPage).fadeOut("fast");
        if (replyPage<maxReplyPage) {
            replyPage++;
        }
        $("#replyPage").text(replyPage);
        $(".replylog"+replyPage).fadeIn("fast");
    }
    function showCurReplyPage() {
        $(".replylog"+replyPage).fadeIn("fast");
    }


    function goNextPraisePage() {
        $(".praiselog"+praisePage).fadeOut("fast");
        if (praisePage>1) {
            praisePage--;
        }
        $("#praisePage").text(praisePage);
        $(".praiselog"+praisePage).fadeIn("fast");
    }
    function goPreviousPraisePage() {
        $(".praiselog"+praisePage).fadeOut("fast");
        if (praisePage<maxPraisePage) {
            praisePage++;
        }
        $("#praisePage").text(praisePage);
        $(".praiselog"+praisePage).fadeIn("fast");
    }
    function showCurPraisePage() {
        $(".praiselog"+praisePage).fadeIn("fast");
    }

    function goNextEvaluatePage() {
        $(".evaluatelog"+evluatePage).fadeOut("fast");
        if (evluatePage>1) {
            evluatePage--;
        }
        $("#evaluatePage").text(evluatePage);
        $(".evaluatelog"+evluatePage).fadeIn("fast");
    }
    function goPreviousEvaluatePage() {
        $(".evaluatelog"+evluatePage).fadeOut("fast");
        if (evluatePage<maxEvaluatePage) {
            evluatePage++;
        }
        $("#evaluatePage").text(evluatePage);
        $(".evaluatelog"+evluatePage).fadeIn("fast");
    }
    function showCurEvaluatePage() {
        $(".evaluatelog"+evluatePage).fadeIn("fast");
    }

</script>
</body>
</html>