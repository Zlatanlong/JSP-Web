package servlet;

import dao.DishDao;
import dao.EvaluateDao;
import entity.Evaluate;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class EvaluateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Evaluate ev = new Evaluate();
        EvaluateDao edao = new EvaluateDao();
        DishDao ddao=new DishDao();
        User user = ((User) request.getSession().getAttribute("user"));
        int did=Integer.valueOf(request.getParameter("dishid"));
        if (user.getName() != null) {
            if (!edao.ifEvaluated(user.getName(),did)) {
                //没有评价过该菜
                ev.setName(user.getName());
                ev.setDishid(did);
                ev.setSalty(Integer.valueOf(request.getParameter("salty")));
                ev.setSweet(Integer.valueOf(request.getParameter("sweet")));
                ev.setSour(Integer.valueOf(request.getParameter("sour")));
                ev.setHot(Integer.valueOf(request.getParameter("hot")));
                edao.insertEvaluate(ev);
                ddao.changeFlavour(Integer.valueOf(request.getParameter("dishid")),
                        Integer.valueOf(request.getParameter("salty")),
                        Integer.valueOf(request.getParameter("sweet")),
                        Integer.valueOf(request.getParameter("sour")),
                        Integer.valueOf(request.getParameter("hot")));
                response.sendRedirect("../details.jsp?id="+did);
            } else {
                //评价过该菜
                //通过ajax显示记录
            }
        } else {
            //没有登录
            response.sendRedirect("../login.html");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //doPost(request, response);
    }
}
