package dao;

import entity.Praise;
import util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PraiseDao {
    public void insertPraise(int uid,int rid){
            Connection conn = null;
            PreparedStatement ptmt = null;
            try {
                conn = DBHelper.getConnection();
                String sql = "insert into `2016_s1_praise`(uid, rid)values (?,?);"; // SQL语句
                ptmt = conn.prepareStatement(sql);
                ptmt.setInt(1, uid);
                ptmt.setInt(2, rid);
                ptmt.executeUpdate();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
    }

    //查询某用户的点赞记录 根据id
    public ArrayList<Praise> getPraiseByUid(int uid) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        ArrayList<Praise> list = new ArrayList<Praise>();
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_praise` where uid=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, uid);
            rs = ptmt.executeQuery();
            while (rs.next()) {
                Praise praise = new Praise();
                praise.setId(rs.getInt("id"));
                praise.setRid(rs.getInt("rid"));
                praise.setUid(rs.getInt("uid"));
                list.add(praise);
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

    //判断某用户是否点赞过某条记录
    public Boolean ifPraised(int uid, int rid) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_praise` where rid=? and uid=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, rid);
            ptmt.setInt(2, uid);
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
