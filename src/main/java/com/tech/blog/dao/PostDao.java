package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class PostDao {
	Connection conn;

	public PostDao(Connection conn) {
		super();
		this.conn = conn;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<>();
		try {
			String SELECT_CATEGORIES = "select * from categories";
			PreparedStatement pstmt = this.conn.prepareStatement(SELECT_CATEGORIES);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String description = rs.getString("description");

				// Create category object and make one object for every row and add to arraylist
				Category category = new Category(id, name, description);
				list.add(category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean addPost(Post post) {
		boolean result = true;
		try {
			String ADD_POST = "insert into posts(user_id,category_id,title,content,code,post_image) values (?,?,?,?,?,?)";
			PreparedStatement pstsmt = this.conn.prepareStatement(ADD_POST);
			pstsmt.setInt(1, post.getUser_id());
			pstsmt.setInt(2, post.getCategory_id());
			pstsmt.setString(3, post.getTitle());
			pstsmt.setString(4, post.getContent());
			pstsmt.setString(5, post.getCode());
			pstsmt.setString(6, post.getPost_image());
			pstsmt.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public List<Post> getAllPosts() {
		List<Post> list = new ArrayList<>();
		try {
			String ALL_POSTS = "select * from posts order by created_at desc";
			PreparedStatement pstmt = this.conn.prepareStatement(ALL_POSTS);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				int user_id = rs.getInt("user_id");
				int category_id = rs.getInt("category_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String code = rs.getString("code");
				String post_image = rs.getString("post_image");
				Timestamp created_at = rs.getTimestamp("created_at");

				// Create object for every post and add in list
				Post post = new Post(id, user_id, category_id, title, content, code, post_image, created_at);
				list.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<Post> getPostByCategory(int category_id) {
		List<Post> list = new ArrayList<>();
		try {
			String ALL_POSTS = "select * from posts where category_id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(ALL_POSTS);
			pstmt.setInt(1, category_id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				int user_id = rs.getInt("user_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String code = rs.getString("code");
				String post_image = rs.getString("post_image");
				Timestamp created_at = rs.getTimestamp("created_at");

				// Create object for every post and add in list
				Post post = new Post(id, user_id, category_id, title, content, code, post_image, created_at);
				list.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Post getPostById(int post_id) {
		Post post = null;
		try {
			String POST_BY_ID = "select * from posts where id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(POST_BY_ID);
			pstmt.setInt(1, post_id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				int id = rs.getInt("id");
				int user_id = rs.getInt("user_id");
				int category_id = rs.getInt("category_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String code = rs.getString("code");
				String post_image = rs.getString("post_image");
				Timestamp created_at = rs.getTimestamp("created_at");

				post = new Post(id, user_id, category_id, title, content, code, post_image, created_at);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}

	public List<Post> getLatestPosts() {
		List<Post> list = new ArrayList<>();
		try {
			String LATEST_POSTS = "select * from posts order by created_at desc limit 5";
			PreparedStatement pstmt = this.conn.prepareStatement(LATEST_POSTS);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				int user_id = rs.getInt("user_id");
				int category_id = rs.getInt("category_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String code = rs.getString("code");
				String post_image = rs.getString("post_image");
				Timestamp created_at = rs.getTimestamp("created_at");

				// Create object for every post and add in list
				Post post = new Post(id, user_id, category_id, title, content, code, post_image, created_at);
				list.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}