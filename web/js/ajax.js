var httpRequest = new XMLHttpRequest();

// 注册判断是否已经有用户
function checkUn() {
    var url = "servlet/CheckServlet?action=checkUn&un=" + un.value;
    // alert("触发了事件");
    httpRequest.open("Get", url, true);
    httpRequest.send();
    httpRequest.onreadystatechange = responseUn;
}

function responseUn() {
    //检查用户名的结果
    if (httpRequest.readyState == 4 && httpRequest.status == 200) {
        var r = httpRequest.responseText.trim();
        if (r == "true") {
            unIsOk = true;
        } else {
            unIsOk = false;
        }
    }
}

/**
 * 登录的检查
 */
function checkLogin() {
    var url = "servlet/LoginServlet?action=checkLogin&un=" + un.value + "&mypwd=" + mypwd.value
        + "&r=Math.random();";
    httpRequest.open("Get", url, true);
    httpRequest.send();
    httpRequest.onreadystatechange = responseLogin;
}

function responseLogin() {
    //检查登录的结果
    if (httpRequest.readyState == 4 && httpRequest.status == 200) {
        var r = httpRequest.responseText.trim();
        if (r == "true") {
            loginIsOk = true;
        } else {
            loginIsOk = false;
        }
    }
}

/**点赞
 *
 * @param rid 回复的id
 * @param did 菜的id
 * @constructor
 */
function addPraise(rid, did) {
    var url = "servlet/AddPraiseServlet?rid=" + rid + "&id=" + did;
    httpRequest.open("Get", url, true);
    httpRequest.send();
    httpRequest.onreadystatechange = responseAddPraise;
}

function responseAddPraise() {
    //检查登录的结果
    if (httpRequest.readyState == 4 && httpRequest.status == 200) {
        var r = httpRequest.responseText.trim();
        if (r == "praised") {
            //赞过了
            alert("您已经赞过了该条评论！");
        } else if (r == "nouser") {
            alert("您还没有登录")
        } else {
            //没赞过，r返回的就是rid"+"新的点赞数，通过加号分开
            var str = r.split("+");
            var pid = "praise" + str[0];
            var iid = "icon" + str[0];
            document.getElementById(pid).innerText = str[1];
            document.getElementById(iid).className = "iconfont icon-dianzan";
        }
    }
}

