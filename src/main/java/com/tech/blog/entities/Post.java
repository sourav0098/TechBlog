package com.tech.blog.entities;

import java.sql.Timestamp;

public class Post {
	private int id;
	private int user_id;
	private int category_id;
	private String title;
	private String content;
	private String code;
	private String post_image;
	private Timestamp created_at;
	
	public Post() {
		super();
	}

	public Post(int category_id, int user_id, String title, String content, String code, String post_image) {
		super();
		this.user_id = user_id;
		this.category_id = category_id;
		this.title = title;
		this.content = content;
		this.code = code;
		this.post_image = post_image;
	}

	public Post(int id, int user_id,int category_id, String title, String content, String code, String post_image,
			Timestamp created_at) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.category_id = category_id;
		this.title = title;
		this.content = content;
		this.code = code;
		this.post_image = post_image;
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

	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getPost_image() {
		return post_image;
	}
	public void setPost_image(String post_image) {
		this.post_image = post_image;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}	
}
