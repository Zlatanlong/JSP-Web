package dao;

import entity.Dish;
import util.DBHelper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

//商品的业务逻辑类
public class DishDao {

    // 获得所有的菜信息
    public ArrayList<Dish> getAllDishes() {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        ArrayList<Dish> list = new ArrayList<Dish>(); // 商品集合
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_dishes`;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            rs = ptmt.executeQuery();
            putRsInList(rs, list);
            return list; // 返回集合。
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            // 释放数据集对象
            if (rs != null) {
                try {
                    rs.close();
                    rs = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            // 释放语句对象
            if (ptmt != null) {
                try {
                    ptmt.close();
                    ptmt = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    /**
     * 把sql查询结果rs返回到list
     *
     * @param rs   菜的集合
     * @param list
     * @throws SQLException
     */
    private void putRsInList(ResultSet rs, ArrayList<Dish> list) throws SQLException {
        while (rs.next()) {
            Dish dish = new Dish();
            dish.setId(rs.getInt("id"));
            dish.setName(rs.getString("name"));
            dish.setWname(rs.getString("wname"));
            dish.setSalty(rs.getFloat("salty"));
            dish.setSweet(rs.getFloat("sweet"));
            dish.setSour(rs.getFloat("sour"));
            dish.setHot(rs.getFloat("hot"));
            dish.setPrice(rs.getFloat("price"));
            dish.setImgurl(rs.getString("imgurl"));
            list.add(dish);// 把一个食品加入集合
        }
    }

    // 根据商品编号获得菜品资料
    public Dish getDishById(int id) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_dishes` where id=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, id);
            rs = ptmt.executeQuery();
            if (rs.next()) {
                Dish dish = new Dish();
                dish.setId(rs.getInt("id"));
                dish.setName(rs.getString("name"));
                dish.setWname(rs.getString("wname"));
                dish.setSalty(rs.getFloat("salty"));
                dish.setSweet(rs.getFloat("sweet"));
                dish.setSour(rs.getFloat("sour"));
                dish.setHot(rs.getFloat("hot"));
                dish.setPrice(rs.getFloat("price"));
                dish.setImgurl(rs.getString("imgurl"));
                return dish;
            } else {
                return null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            // 释放数据集对象
            if (rs != null) {
                try {
                    rs.close();
                    rs = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            // 释放语句对象
            if (ptmt != null) {
                try {
                    ptmt.close();
                    ptmt = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    // 根据食堂窗口名获得菜品
    public ArrayList<Dish> getDishesByWname(String wname) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        ArrayList<Dish> list = new ArrayList<>(); // 商品集合
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_dishes` where wname=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, wname);
            rs = ptmt.executeQuery();
            putRsInList(rs, list);
            return list; // 返回集合。
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            // 释放数据集对象
            if (rs != null) {
                try {
                    rs.close();
                    rs = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            // 释放语句对象
            if (ptmt != null) {
                try {
                    ptmt.close();
                    ptmt = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    //根据菜名获得菜品
    public ArrayList<Dish> getDishesByName(String name) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        ArrayList<Dish> list = new ArrayList<>(); // 商品集合
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_dishes` where name=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, name);
            rs = ptmt.executeQuery();
            putRsInList(rs, list);
            return list; // 返回集合。
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            // 释放数据集对象
            if (rs != null) {
                try {
                    rs.close();
                    rs = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            // 释放语句对象
            if (ptmt != null) {
                try {
                    ptmt.close();
                    ptmt = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }


    //获取最近浏览的前五条菜品信息
    public ArrayList<Dish> getViewList(String list) {
        ArrayList<Dish> dishlist = new ArrayList<Dish>();
        int iCount = 5; //每次返回前五条记录
        if (list != null && list.length() > 0) {
            String[] arr = list.split(",");
            //如果商品记录大于等于5条
            int i = arr.length - 1;
            while ((i >= 0) && dishlist.size() <= 4) {
                int flag = 0;
                for (Dish it : dishlist) {
                    if (it.getId() == Integer.parseInt(arr[i])) {
                        flag = 1;
                    }
                }
                if (flag == 0 && getDishById(Integer.parseInt(arr[i])) != null) {
                    Dish dish = getDishById(Integer.parseInt(arr[i]));
                    dishlist.add(dish);
                }
                i--;
            }
            return dishlist;
        } else {
            return null;
        }
    }

    //更改口味
    public void changeFlavour(int dishid, int salty, int sweet, int sour, int hot) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        Dish dish = getDishById(dishid);
        try {
            conn = DBHelper.getConnection();
            String sql = "update `2016_s1_dishes` set salty=?,sweet=?,sour=?,hot=?" +
                    " where id=?"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setFloat(1, (salty + dish.getSalty()) / 2);
            ptmt.setFloat(2, (sweet + dish.getSweet()) / 2);
            ptmt.setFloat(3, (sour + dish.getSour()) / 2);
            ptmt.setFloat(4, (hot + dish.getHot()) / 2);
            ptmt.setInt(5, dishid);
            ptmt.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //添加一个菜
    public void insertDish(Dish dish) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "insert into `2016_s1_dishes`(name, wname, salty, sweet, sour, hot, price, imgurl) " +
                    "VALUES (?,?,?,?,?,?,?,?)"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, dish.getName());
            ptmt.setString(2, dish.getWname());
            ptmt.setFloat(3, 3);
            ptmt.setFloat(4, 3);
            ptmt.setFloat(5, 3);
            ptmt.setFloat(6, 3);
            ptmt.setFloat(7, dish.getPrice());
            ptmt.setString(8, dish.getImgurl());
            ptmt.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //删除一个菜
    public void delDish(Dish dish) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "delete from `2016_s1_dishes` where id=?"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, dish.getId());
            ptmt.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //获得所有窗口名
    public ArrayList<String> getAllWindows() {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        ArrayList<String> list = new ArrayList<>(); // 商品集合
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_windows`"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            rs = ptmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("wname"));
            }
            return list; // 返回集合。
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            // 释放数据集对象
            if (rs != null) {
                try {
                    rs.close();
                    rs = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            // 释放语句对象
            if (ptmt != null) {
                try {
                    ptmt.close();
                    ptmt = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    //获得所有菜名
    public ArrayList<String> getAllNames() {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        ArrayList<String> list = new ArrayList<>(); // 商品集合
        try {
            conn = DBHelper.getConnection();
            String sql = "select name from `2016_s1_dishes`"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            rs = ptmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("name"));
            }
            return list; // 返回集合。
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            // 释放数据集对象
            if (rs != null) {
                try {
                    rs.close();
                    rs = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            // 释放语句对象
            if (ptmt != null) {
                try {
                    ptmt.close();
                    ptmt = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    //按照口味 taste 排序取8个顶级的菜
    public ArrayList<Dish> getOrderByTaste(String taste) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<Dish> list = new ArrayList<Dish>(); // 商品集合
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_dishes` order by " + taste + " desc"; // SQL语句
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next() && list.size() < 8) {
                Dish dish = new Dish();
                dish.setId(rs.getInt("id"));
                dish.setName(rs.getString("name"));
                dish.setWname(rs.getString("wname"));
                dish.setSalty(rs.getFloat("salty"));
                dish.setSweet(rs.getFloat("sweet"));
                dish.setSour(rs.getFloat("sour"));
                dish.setHot(rs.getFloat("hot"));
                dish.setPrice(rs.getFloat("price"));
                dish.setImgurl(rs.getString("imgurl"));
                list.add(dish);// 把一个食品加入集合
            }
            return list; // 返回集合。
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            // 释放数据集对象
            if (rs != null) {
                try {
                    rs.close();
                    rs = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            // 释放语句对象
            if (stmt != null) {
                try {
                    stmt.close();
                    stmt = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
}
