package servlet;

import dao.DishDao;
import entity.Dish;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ManageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getParameter("action");
        DishDao dishDao = new DishDao();
        if (action.equals("del")) {
            int id = Integer.parseInt(request.getParameter("id"));
            //删除该菜品！
            dishDao.delDish(dishDao.getDishById(id));
            response.sendRedirect("../manager.jsp");
        } else if (action.equals("add")) {
            Dish dish=new Dish();
            dish.setName(request.getParameter("name"));
            dish.setWname(request.getParameter("wname"));
            dish.setPrice(Float.parseFloat(request.getParameter("price")));
            dish.setImgurl((String) request.getSession().getAttribute("dishimgurl"));
            dishDao.insertDish(dish);
            response.sendRedirect("../manager.jsp");
        } else {

        }
    }
}
