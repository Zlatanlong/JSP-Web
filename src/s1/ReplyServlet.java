package s1;

import dao.ReplyDao;
import entity.Reply;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReplyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        User user = ((User) request.getSession().getAttribute("user"));
        Reply reply=new Reply();
        ReplyDao rdao=new ReplyDao();
        if (user.getName() != null) {
                //有用户
                reply.setUname(user.getName());
                reply.setText(request.getParameter("text"));
                reply.setDname(request.getParameter("dishname"));
                reply.setDid(Integer.valueOf(request.getParameter("dishid")));
            rdao.insertReply(reply);
                response.sendRedirect("../s1/details.jsp?id="+request.getParameter("dishid"));
        } else {
            //没有登录
            response.sendRedirect("../s1/login.html");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
