package dao;

import entity.User;
import util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {
    /**
     * 根据用户名un返回User
     *
     * @param un
     * @return
     */
    public User getUserByName(String un) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_users` where name=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, un);
            rs = ptmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setRight(rs.getInt("right"));
                user.setSex(rs.getString("sex"));
                user.setAge(rs.getInt("age"));
                user.setCollegeid(rs.getInt("collegeid"));
                return user;
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

    //添加一个用户
    public void insertUser(User user) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "insert into `2016_s1_users`(name, password, `right`, sex, age, collegeid) " +
                    "VALUES (?,?,?,?,?,?)"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, user.getName());
            ptmt.setString(2, user.getPassword());
            ptmt.setInt(3, user.getRight());
            ptmt.setString(4, user.getSex());
            ptmt.setInt(5, user.getAge());
            ptmt.setInt(6, user.getCollegeid());
            ptmt.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //判断一个用户是否是管理人员
    public Boolean ifManager(User user) {
        if (user.getRight() == 2) {
            return true;
        } else {
            return false;
        }
    }

    //查询一个用户所在学校
    public String getSchoolName(User user) {
        int cid = user.getCollegeid();
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "Select `2016_s1_colleges`.name from `2016_s1_colleges`,`2016_s1_users` " +
                    "where collegeid=`2016_s1_colleges`.id " +
                    "and `2016_s1_users`.id=?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, user.getId());
            rs = ptmt.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
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

    public String getRight(User user) {
        if (user.getRight() != 0) {
            if (user.getRight() == 1) {
                return "在校学生";
            } else if (user.getRight() == 2) {
                return "菜品管理员";
            }
        }
        return null;
    }
}
