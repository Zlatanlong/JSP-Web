<%@ page import="dao.DishDao" %>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
    DishDao dishDao = new DishDao();
    ArrayList<String> wnamelist = dishDao.getAllWindows();
%>
<!doctype html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>增加菜品</title>
    <link rel="stylesheet" type="text/css" href="css/login_css.css">
    <link rel="stylesheet" href="css/nice-select.css">
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/jquery.nice-select.js"></script>
    <script>
        $(document).ready(function () {
            $('select').niceSelect();
        });
    </script>
</head>
<body>
<div class="htmleaf-container">
    <div class="wrapper">
        <div class="container">
            <h1>增加菜品</h1>

            <form class="form" method="post" action="servlet/ManageServlet" onsubmit="return checkSub()">
                <input type="hidden" name="action" value="add">
                <div class="form-input">
                    <select name="wname" class="wide">
                        <%
                            if (wnamelist != null && wnamelist.size() > 0) {
                                for (String wname : wnamelist) {
                        %>
                        <option value="<%=wname%>"><%=wname%>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <input type="text" placeholder="菜名" name="name" id="un">
                <input type="text" placeholder="价格" name="price" id="price">
                <input type="text" name="check" id="check" disabled="true">
                <div class="form-input">
                    <iframe src="upload.html" frameborder=0 height="44" width="300"></iframe>
                </div>
                <button type="submit" id="login-button">提交</button>
                <button type="button" id="shift-href" onclick="goToLogin()">返回</button>
            </form>
        </div>
        <!--背景特效-->
        <ul class="bg-bubbles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>
<%--跳转--%>
<script>
    function goToLogin() {
        window.location.href = "manager.jsp";
    }


</script>
<%--检查上传图片，和价格格式--%>
<script>
    var check = document.getElementById("check");

    function checkSub() {
        // isNaN()函数 把空串 空格 以及NUll 按照0来处理 所以先去除
        var isSubImg=true;
        if (isSubImg) {
            var val = document.getElementById("price").value;
            if (val == "" || val == null) {
                check.value = "请输入正确的价格！";
                $("#check").slideDown("fast");
                return false;
            }
            if (!isNaN(val)) {
                check.value = "上传成功！";
                $("#check").slideUp("fast");
                return true;
            } else {
                check.value = "请输入正确的价格！";
            }
        }else {
            check.value = "请上传图片！";
        }
        $("#check").slideDown("fast");
        return false;
    }
</script>
</body>
</html>