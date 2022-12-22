package com.tech.blog.entities;

import java.sql.Timestamp;

public class Comment {
	private int id,user_id,post_id;
	private String comment;
	private Timestamp created_at;
	
	public Comment() {
		super();
	}
	public Comment(int user_id, int post_id, String comment) {
		super();
		this.user_id = user_id;
		this.post_id = post_id;
		this.comment = comment;
	}
	public Comment(int id, int user_id, int post_id, String comment, Timestamp created_at) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.post_id = post_id;
		this.comment = comment;
		this.created_at = created_at;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}	
}