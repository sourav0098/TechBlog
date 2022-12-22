package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Comment;

public class CommentDao {
	Connection conn;

	public CommentDao(Connection conn) {
		super();
		this.conn = conn;
	}

	public boolean AddComment(Comment comment) {
		boolean result = false;
		try {
			String ADD_COMMENT = "insert into comments(post_id,user_id,comment) values(?,?,?)";
			PreparedStatement pstmt = this.conn.prepareStatement(ADD_COMMENT);
			pstmt.setInt(1, comment.getPost_id());
			pstmt.setInt(2, comment.getUser_id());
			pstmt.setString(3, comment.getComment());
			pstmt.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<Comment> getCommentsByPost(int post_id) {
		List<Comment> comments = new ArrayList<>();
		try {
			String SELECT_COMMENTS = "select * from comments where post_id=? order by created_at desc";
			PreparedStatement pstmt = this.conn.prepareStatement(SELECT_COMMENTS);
			pstmt.setInt(1, post_id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				int user_id = rs.getInt("user_id");
				String commentString = rs.getString("comment");
				Timestamp created_at = rs.getTimestamp("created_at");

				Comment comment = new Comment(id, user_id, post_id, commentString, created_at);
				comments.add(comment);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return comments;
	}

	public boolean updateComment(Comment comment) {
		boolean result = false;
		try {
			String UPDATE_COMMENT = "update comments set comment=?,created_at=? where id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(UPDATE_COMMENT);
			pstmt.setString(1, comment.getComment());
			pstmt.setTimestamp(2, comment.getCreated_at());
			pstmt.setInt(3, comment.getId());
			pstmt.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int countCommentsByPost(int post_id) {
		int count = 0;
		try {
			String COUNT_COMMENTS = "select count(id) from comments where post_id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(COUNT_COMMENTS);
			pstmt.setInt(1, post_id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count(id)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public boolean deleteComment(int post_id, int user_id) {
		boolean result = false;
		try {
			String DELETE_COMMENT = "delete from comments where post_id=? and user_id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(DELETE_COMMENT);
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