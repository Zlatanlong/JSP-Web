package servlet;

import dao.UserDao;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CheckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String un=request.getParameter("un");
        if (action.equals("checkUn")) {
            UserDao userDao=new UserDao();
            User user =userDao.getUserByName(un);
            if (userDao.getUserByName(un)!=null) {
                //已经有该用户了
                response.getWriter().print("false");
            }else {
                //没有用户存在,可以建
                response.getWriter().print("true");
            }
        }
    }
}
