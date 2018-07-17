package s1;

import dao.UserDao;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    UserDao udao = new UserDao();

    //判断用户名密码是否正确
    public Boolean ifLoginSuccess(String un, String pwd) {
        User user = udao.getUserByName(un);
        if (user != null) {
            if (user.getPassword().equals(pwd)) {
                return true;
            } else {
                System.out.println("密码不正确");
                return false;
            }
        } else {
            System.out.println("没找到该用户！");
            //用户名不正确
            return false;
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String un = request.getParameter("un");
        String pwd = request.getParameter("mypwd");
        if (ifLoginSuccess(un, pwd)) {
            //登录成功
            //把用户存到session
            request.getSession().setAttribute("user", udao.getUserByName(request.getParameter("un")));
            response.sendRedirect("../s1/index.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getParameter("action");
        String un = request.getParameter("un");
        String pwd = request.getParameter("mypwd");
        if (action.equals("checkLogin")) {
            if (ifLoginSuccess(un, pwd)) {
                //登录成功
                response.getWriter().print("true");
            } else {
                response.getWriter().print("false");
            }
        }
    }
}
