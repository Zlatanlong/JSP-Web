package servlet;

import dao.UserDao;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        UserDao userDao = new UserDao();
        if (request.getParameter("un") != null) {
            //输入了用户名
            User user = new User();
            user.setName(request.getParameter("un"));
            user.setPassword(request.getParameter("pwd"));
            user.setRight(1);//正常注册的用户权限都是1
            user.setSex(request.getParameter("sex"));
            user.setAge(Integer.parseInt(request.getParameter("age")));
            user.setCollegeid(Integer.parseInt(request.getParameter("collegeid")));
            userDao.insertUser(user);
            response.sendRedirect("../login.html");

        } else {
            //没有输入用户名
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
