package servlet;

import dao.PraiseDao;
import dao.ReplyDao;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddPraiseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        ReplyDao replyDao = new ReplyDao();
        PraiseDao praiseDao = new PraiseDao();
        User user = ((User) request.getSession().getAttribute("user"));
        int rid = Integer.parseInt(request.getParameter("rid"));
        if (user.getName() != null) {
            //如果登录了
            if (!praiseDao.ifPraised(user.getId(), rid)) {
                //没有点赞过
                praiseDao.insertPraise(user.getId(), rid);
                replyDao.addPraise(rid);
                //返回回复id+点赞数的形式
                response.getWriter().print(rid+"+"+replyDao.getPraiseCount(rid));
            } else {
                //点赞过
                response.getWriter().print("praised");
            }
        } else {
            //没有登录
            response.getWriter().print("nouser");
        }


    }
}
