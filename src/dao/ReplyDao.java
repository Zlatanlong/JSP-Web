package dao;

import entity.Reply;
import ljh.util.DateUtil;
import util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReplyDao {

    //插入一个回复
    public void insertReply(Reply re) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "insert into `2016_s1_reply`(uname,text,dname,did,praise,time) " +
                    "VALUES (?,?,?,?,?,?)"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, re.getUname());
            ptmt.setString(2, re.getText());
            ptmt.setString(3, re.getDname());
            ptmt.setInt(4, re.getDid());
            ptmt.setInt(5, re.getPraise());
            ptmt.setString(6, DateUtil.getNow());
            ptmt.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //根据菜ID查询某菜的被回复记录
    public ArrayList<Reply> getReplyByDishId(int did) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        ArrayList<Reply> list = new ArrayList<>();
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_reply` where did=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, did);
            rs = ptmt.executeQuery();
            putResultInList(rs, list);
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

    //点赞
    public void addPraise(int id){
        Connection conn = null;
        PreparedStatement ptmt = null;
        try{
            conn=DBHelper.getConnection();
            String sql="update `2016_s1_reply` set praise = praise+1 where id=?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,id);
            ptmt.executeUpdate();
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }

    //根据id查询某个贴
    public Reply getReply(int id){
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        try{
            conn=DBHelper.getConnection();
            String sql="select * from `2016_s1_reply` where id=?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,id);
            rs = ptmt.executeQuery();
            if (rs.next()) {
                Reply reply = new Reply();
                reply.setId(rs.getInt("id"));
                reply.setUname(rs.getString("uname"));
                reply.setText(rs.getString("text"));
                reply.setDname(rs.getString("dname"));
                reply.setDid(rs.getInt("did"));
                reply.setPraise(rs.getInt("praise"));
                reply.setTime(rs.getString("time"));
                return reply;
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

    //根据用户名查询所有回帖
    public ArrayList<Reply> getRepliesByUname(String un) {
        Connection conn = null;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        ArrayList<Reply> list = new ArrayList<>(); // 商品集合
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from `2016_s1_reply` where uname=?;"; // SQL语句
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, un);
            rs = ptmt.executeQuery();
            putResultInList(rs, list);
            return list; // 返回集合。
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

    //把查询结果返回到list
    private void putResultInList(ResultSet rs, ArrayList<Reply> list) throws SQLException {
        while (rs.next()) {
            Reply reply = new Reply();
            reply.setId(rs.getInt("id"));
            reply.setUname(rs.getString("uname"));
            reply.setText(rs.getString("text"));
            reply.setDname(rs.getString("dname"));
            reply.setDid(rs.getInt("did"));
            reply.setPraise(rs.getInt("praise"));
            reply.setTime(rs.getString("time"));
            list.add(reply);// 把一个食品加入集合
        }
    }

    //根据id查询点赞数
    public int getPraiseCount(int id){
        return getReply(id).getPraise();
    }
}
