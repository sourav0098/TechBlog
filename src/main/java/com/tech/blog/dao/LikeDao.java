package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	Connection conn;

	public LikeDao(Connection conn) {
		super();
		this.conn = conn;
	}

	public boolean addLike(int post_id,int user_id) {
		boolean result = false;
		try {
			String INSERT_LIKE = "insert into likes (post_id,user_id) values(?,?)";
			PreparedStatement pstmt = this.conn.prepareStatement(INSERT_LIKE);
			pstmt.setInt(1, post_id);
			pstmt.setInt(2, user_id);
			pstmt.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int countLike(int post_id) {
		int likes = 0;
		try {
			String COUNT_LIKES="select count(id) from likes where post_id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(COUNT_LIKES);
			pstmt.setInt(1, post_id);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				likes=rs.getInt("count(id)");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return likes;
	}
	
	public boolean isLikedByUser(int post_id,int user_id) {
		boolean result=false;
		try {
			String IF_LIKED="select * from likes where post_id=? and user_id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(IF_LIKED);
			pstmt.setInt(1, post_id);
			pstmt.setInt(2, user_id);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {				
				result = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean deleteLike(int post_id,int user_id) {
		boolean result = false;
		try {
			String DELETE_LIKE = "delete from likes where post_id=? and user_id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(DELETE_LIKE);
			pstmt.setInt(1, post_id);
			pstmt.setInt(2, user_id);
			pstmt.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}