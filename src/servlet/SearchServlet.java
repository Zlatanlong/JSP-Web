package servlet;

import dao.DishDao;
import entity.Dish;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class SearchServlet extends HttpServlet {
    static DishDao  dishDao = new DishDao();
    static List<String> datas = dishDao.getAllNames();

    static {
        for (String wname : dishDao.getAllWindows()) {
            datas.add(wname);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        List<Dish> dishList=new ArrayList<>();
        String keyword = request.getParameter("keyword");
        for (String data : datas) {
            if (data.contains(keyword)) {
                for (Dish dish : dishDao.getDishesByName(data)) {
                    dishList.add(dish);
                }
                for (Dish dish : dishDao.getDishesByWname(data)) {
                    dishList.add(dish);
                }
            }
        }
        request.getSession().setAttribute("search_result",dishList);
        response.sendRedirect("../search_result.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //首先获得客户端发来的数据keyword
        String keyword = request.getParameter("keyword");
        //获得数据后进行处理，得到关联数据
        response.getWriter().print(getOut(getData(keyword)));
    }

    //得到关联数据的方法
    public List<String> getData(String keyword) {
        List<String> list = new ArrayList<>();
        for (String data : datas) {
            if (data.contains(keyword)) {
                 list.add(data);
            }
        }
        return list;
    }

    //获得输出数据的方法
    public String getOut(List<String> list){
        StringBuffer sb=new StringBuffer();
        for (String s : list) {
            sb.append(s).append("$");
        }
        return String.valueOf(sb);
    }
}
