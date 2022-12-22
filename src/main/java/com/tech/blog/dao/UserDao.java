package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {
	private Connection conn;

	public UserDao(Connection conn) {
		this.conn = conn;
	}

	// Method to insert user to database
	public boolean registerUser(User user) {
		boolean result = false;
		try {
			// User-> DB
			String INSERT_USER = "insert into users(name,email,password,gender,about) values(?,?,?,?,?)";
			PreparedStatement pstmt = this.conn.prepareStatement(INSERT_USER);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			pstmt.executeUpdate();
			result = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	// Get user by email and password
	public User getUserByEmailandPassword(String email, String password) {
		User user = null;
		try {
			String SELECT_USER = "select * from users where email=? and password=?";
			PreparedStatement pstmt = this.conn.prepareStatement(SELECT_USER);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				user = new User();

				// Getting data from DB using result set and setting the values in user obj
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setCreated_at(rs.getTimestamp("created_at"));
				user.setProfile(rs.getString("image"));

			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return user;
	}
	
	public boolean updateUser(User user) {
		boolean result = false;
		try {
			String UPDATE_USER="update users set name=?,email=?,password=?,gender=?,about=?,image=? where id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(UPDATE_USER);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			pstmt.setString(6, user.getProfile());
			pstmt.setInt(7, user.getId());
			pstmt.executeUpdate();
			result=true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public User getUserByUserId(int user_id) {
		User user=null;
		try {
			String GET_USER_BY_USER_ID="select * from users where id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(GET_USER_BY_USER_ID);
			pstmt.setInt(1, user_id);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				user=new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setCreated_at(rs.getTimestamp("created_at"));
				user.setProfile(rs.getString("image"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}
}
