package dao;

import entity.Evaluate;
import util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EvaluateDao {

    public void insertEvaluate(Evaluate ev) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "insert into `2016_s1_evaluate`(uname, did, salty, sweet, sour, hot) " +
                    "VALUES (?,?,?,?,?,?)"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, ev.getName());
            ptmt.setInt(2, ev.getDishid());
            ptmt.setInt(3, ev.getSalty());
            ptmt.setInt(4, ev.getSweet());
            ptmt.setInt(5, ev.getSour());
            ptmt.setInt(6, ev.getHot());
            ptmt.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //查询某用户的评价记录
    public ArrayList<Evaluate> getEvaluateByUname(String un) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        ArrayList<Evaluate> list = new ArrayList<Evaluate>();
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_evaluate` where uname=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, un);
            rs = ptmt.executeQuery();
            while (rs.next()) {
                Evaluate evaluate = new Evaluate();
                evaluate.setId(rs.getInt("id"));
                evaluate.setName(rs.getString("uname"));
                evaluate.setDishid(rs.getInt("did"));
                evaluate.setSalty(rs.getInt("salty"));
                evaluate.setSweet(rs.getInt("sweet"));
                evaluate.setSour(rs.getInt("sour"));
                evaluate.setHot(rs.getInt("hot"));
                list.add(evaluate);
            }
            return list;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }finally {
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
     * 根据用户名un和菜did查询评价
     *
     * @param un
     * @param did
     * @return
     */
    public Evaluate getEvaluate(String un, int did) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_evaluate` where uname=? and did=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, un);
            ptmt.setInt(2, did);
            rs = ptmt.executeQuery();
            if (rs.next()) {
                Evaluate evaluate = new Evaluate();
                evaluate.setId(rs.getInt("id"));
                evaluate.setName(rs.getString("uname"));
                evaluate.setDishid(rs.getInt("did"));
                evaluate.setSalty(rs.getInt("salty"));
                evaluate.setSweet(rs.getInt("sweet"));
                evaluate.setSour(rs.getInt("sour"));
                evaluate.setHot(rs.getInt("hot"));
                return evaluate;
            } else {
                return null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }finally {
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
     * 用户是否评价过某菜品
     *
     * @param un  用户的用户名
     * @param did 菜品id
     * @return 评价过返回 true，否则返回 false
     */
    public Boolean ifEvaluated(String un, int did) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_evaluate` where uname=? and did=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, un);
            ptmt.setInt(2, did);
            rs = ptmt.executeQuery();
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }finally {
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
}
