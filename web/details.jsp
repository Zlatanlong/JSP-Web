<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%@ page import="entity.Dish" %>
<%@ page import="dao.DishDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="dao.ReplyDao" %>
<%@ page import="entity.Reply" %>
<%@ page import="dao.EvaluateDao" %>
<%@ page import="entity.User" %>
<%@ page import="entity.Evaluate" %>
<%@ page import="dao.PraiseDao" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    User user = ((User) session.getAttribute("user"));

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>菜品详情</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script src="js/ajax.js"></script>
    <link rel="stylesheet" type="text/css" href="css/dzcomment.css">
    <link rel="stylesheet" type="text/css" href="css/dzstyle.css">
    <link rel="stylesheet" type="text/css" href="//at.alicdn.com/t/font_748200_1rbctpd78w1.css">
    <link rel="stylesheet" type="text/css" href="css/ly.css">
    <style>
        html{
            color: white;
        }

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
    </style>
</head>

<body>
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

<table>
    <tr>
        <!-- 商品详情 -->
        <%
            DishDao dishDao = new DishDao();
            Dish dish = dishDao.getDishById(Integer.parseInt(request.getParameter("id")));
            if (dish != null) {
        %>
        <td class="mainLine" width="30%" valign="top">
            <%--详细信息--%>
            <table>
                <tr>
                    <td rowspan="4"><img src="../img/<%=dish.getImgurl()%>" width="200" height="160"/></td>
                </tr>
                <tr>
                    <td><B><%=dish.getName() %>
                    </B></td>
                </tr>
                <tr>
                    <td>食堂：<br>
                        <%=dish.getWname()%>
                    </td>
                </tr>
                <tr>
                    <td>价格：<i class="iconfont icon-msnui-rmb"></i><%=dish.getPrice() %>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#8a2be2">大众点评咸度： <%=dish.getSalty()%>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#db7093">大众点评甜度： <%=dish.getSweet() %>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#7fffd4">大众点评酸度： <%=dish.getSour()%>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="red">大众点评辣度： <%=dish.getHot() %>
                    </td>
                </tr>
            </table>
            <%
                EvaluateDao evaluateDao = new EvaluateDao();

                if (!evaluateDao.ifEvaluated(user.getName(), Integer.parseInt(request.getParameter("id")))) {
                    //没有评价过
            %>
            <%--评价味道--%>
            <form action="servlet/EvaluateServlet" method="post" id="evaluate">
                <%--隐藏传值法--%>
                <input type="hidden" name="dishid" value="<%=request.getParameter("id")%>">
                <table>
                    <tr>
                        <td class="label">咸：</td>
                        <td class="controler">
                            <label><input type="radio" name="salty" value="1">1分</label>
                            <label><input type="radio" name="salty" value="2">2分</label>
                            <label><input type="radio" name="salty" value="3" checked="checked">3分</label>
                            <label><input type="radio" name="salty" value="4">4分</label>
                            <label><input type="radio" name="salty" value="5">5分</label>
                        </td>

                    </tr>
                    <tr>
                        <td class="label">甜：</td>
                        <td class="controler">
                            <label><input type="radio" name="sweet" value="1">1分</label>
                            <label><input type="radio" name="sweet" value="2">2分</label>
                            <label><input type="radio" name="sweet" value="3" checked="checked">3分</label>
                            <label><input type="radio" name="sweet" value="4">4分</label>
                            <label><input type="radio" name="sweet" value="5">5分</label>
                        </td>

                    </tr>

                    <tr>
                        <td class="label">酸：</td>
                        <td class="controler">
                            <label><input type="radio" name="sour" value="1">1分
                            </label> <label><input type="radio" name="sour" value="2">2分
                        </label> <label><input type="radio" name="sour" value="3" checked="checked">3分</label>
                            <label><input type="radio" name="sour" value="4">4分
                            </label> <label><input type="radio" name="sour" value="5">5分
                        </label></td>
                    </tr>
                    <tr>
                        <td class="label">辣：</td>
                        <td class="controler">
                            <label><input type="radio" name="hot" value="1">1分
                            </label> <label><input type="radio" name="hot" value="2">2分
                        </label> <label><input type="radio" name="hot" value="3" checked="checked">3分</label>
                            <label><input type="radio" name="hot" value="4">4分
                            </label> <label><input type="radio" name="hot" value="5">5分
                        </label></td>
                    </tr>
                    <tr>
                        <td class="controler">
                            <input type="submit">
                        </td>
                    </tr>
                </table>
            </form>
            <%
            } else {
                Evaluate evaluate = null;
                evaluate = evaluateDao.getEvaluate(user.getName(), Integer.parseInt(request.getParameter("id")));
            %>
            <%--评价历史--%>
            <table>
                <tr>我的评价：</tr>
                <br>
                <tr>
                    <td>咸度:</td>
                    <td bgcolor="#8a2be2"><%=evaluate.getSalty()%>
                    </td>
                </tr>
                <tr>
                    <td>甜度:</td>
                    <td bgcolor="#db7093"><%=evaluate.getSweet()%>
                    </td>
                </tr>
                <tr>
                    <td>酸度:</td>
                    <td bgcolor="#7fffd4"><%=evaluate.getSour()%>
                    </td>
                </tr>
                <tr>
                    <td>辣度:</td>
                    <td bgcolor="red"><%=evaluate.getHot()%>
                    </td>
                </tr>
            </table>
            <%
                }
            %>

        </td>

        <%
            }
        %>
        <td class="mainLine" width="60%" valign="top">
            <%--评论和回复--%>
            <div class="commentAll">
                <form action="servlet/ReplyServlet" method="post" onsubmit="return replyCheck()">
                    <input type="hidden" name="dishid" value="<%=request.getParameter("id")%>">
                    <input type="hidden" name="dishname" value="<%=dish.getName()%>">
                    <textarea class="content comment-input" placeholder="请留下您对该菜的评价："
                              id="replytext" name="text"></textarea>
                    <input type="submit" value="评论" class="plBtn">
                </form>
                <!--评论区域 end-->
                <%
                    ReplyDao reDao = new ReplyDao();
                    ArrayList<Reply> replyList = reDao.getReplyByDishId(Integer.parseInt(request.getParameter("id")));
                    Collections.reverse(replyList);
                    if (replyList != null && replyList.size() > 0) {
                        for (int k = 0; k < replyList.size(); k += 5) {
                            for (int i = k; i < k + 5 && i < replyList.size(); i++) {
                                Reply reply = replyList.get(i);
                %>
                <!--回复区域 begin-->
                <div class="comment-show replylog<%=(int)k/5+1%>" style="display: none">
                    <div class="comment-show-con clearfix">
                        <div class="comment-show-con-img pull-left"><img src="images/header-img-comment_03.png" alt="">
                        </div>
                        <div class="comment-show-con-list pull-left clearfix">
                            <div class="pl-text clearfix">
                                <a href="javascript:void(0);" class="comment-size-name"><%=reply.getUname()%>
                                </a>
                                <span class="my-pl-con"><%=reply.getText()%></span>
                            </div>
                            <div class="date-dz">
                                <span class="date-dz-left pull-left comment-time"><%=reply.getTime()%></span>
                                <div class="date-dz-right pull-right comment-pl-block"
                                     onclick="addPraise(<%=reply.getId()%>,<%=reply.getDid()%>)">
                                    <%
                                        //开始判断
                                        PraiseDao praiseDao = new PraiseDao();
                                        if (!praiseDao.ifPraised(user.getId(), reply.getId())) {
                                            //没有点赞过
                                    %>
                                    <i class="iconfont icon-buoumaotubiao15" id="icon<%=reply.getId()%>"
                                    ></i>
                                    赞 <i class="z-num" id="praise<%=reply.getId()%>"><%=reply.getPraise()%>
                                        <%
                                        }else{
                                    %>
                                    <i class="iconfont icon-dianzan" id="icon<%=reply.getId()%>"></i>
                                    赞 <i class="z-num" id="praise<%=reply.getId()%>"><%=reply.getPraise()%>
                                        <%
                                            }
                                        %>
                                    </i>
                                </div>
                            </div>
                            <div class="hf-list-con"></div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                } else {
                %>
                <center><p>还没有人评论过该菜，快去评论吧！</p><br>
                </center>
                <%
                    }
                %>
                <!--回复区域 end-->
                <div class="project-pages">
                    <ul>
                        <li><a href="javascript:void(0);" onclick="goNextReplyPage()">向前</a></li>
                        <li>第 <span id="replyPage">1</span> 页</li>
                        <li><a href="javascript:void(0);" onclick="goPreviousReplyPage()">向后</a></li>
                    </ul>
                </div>
            </div>

        </td>

        <%
            String list = "";
            //从客户端获得Cookies集合
            Cookie[] cookies = request.getCookies();
            //遍历这个Cookies集合
            if (cookies != null && cookies.length > 0) {
                for (Cookie c : cookies) {
                    if (c.getName().equals("ListViewCookie")) {
                        list = URLDecoder.decode(c.getValue(), "UTF-8");
                    }
                }
            }

            list += request.getParameter("id") + ",";
            //如果浏览记录超过1000条，删掉1000条之前的.
            String[] arr = list.split(",");
            if (arr != null && arr.length > 0) {
                if (arr.length >= 1000) {
                    list = list.substring(list.length() - 1000, list.length());
                }
            }
            Cookie cookie = new Cookie("ListViewCookie", URLEncoder.encode(list, "UTF-8"));
            response.addCookie(cookie);

        %>
        <!-- 浏览过的菜品 -->
        <td class="mainLine" width="10%" valign="top">
            <br>
            <b>您浏览过的菜品</b><br>
            <!-- 循环开始 -->
            <%
                ArrayList<Dish> dishesList = dishDao.getViewList(list);
                if (dishesList != null && dishesList.size() > 0) {
                    for (Dish i : dishesList) {
            %>
            <div>
                <dl>
                    <dt>
                        <a href="details.jsp?id=<%=i.getId()%>"><img src="../img/<%=i.getImgurl() %>" width="120"
                                                                     height="90" border="1"/></a>
                </dl>
            </div>
            <%
                    }
                }
            %>
            <!-- 循环结束 -->
        </td>
    </tr>
</table>


<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
<%--限制评论字数--%>
<script type="text/javascript">
    function replyCheck() {
        var text = document.getElementById("replytext").value;
        if (text.length < 5) {
            alert("评价不得小于5个字！");
            return false;
        } else {
            return true;
        }
    }

    function keyUP(t) {
        var len = $(t).val().length;
        if (len > 139) {
            $(t).val($(t).val().substring(0, 140));
        }
    }
</script>
<%--分页--%>
<script type="text/javascript">
    var replyPage = 1;
    var maxReplyPage = parseInt(<%=(int)replyList.size()/5+1%>);

    function goNextReplyPage() {
        $(".replylog" + replyPage).fadeOut("fast");
        if (replyPage > 1) {
            replyPage--;
        }
        $("#replyPage").text(replyPage);
        $(".replylog" + replyPage).fadeIn("fast");
    }

    function goPreviousReplyPage() {
        $(".replylog" + replyPage).fadeOut("fast");
        if (replyPage < maxReplyPage) {
            replyPage++;
        }
        $("#replyPage").text(replyPage);
        $(".replylog" + replyPage).fadeIn("fast");
    }

    function showCurReplyPage() {
        $(".replylog" + replyPage).fadeIn("fast");
    }

    $(document).ready(function () {
        showCurReplyPage();
    });
</script>

</body>
</html>