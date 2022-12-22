package com.tech.blog.entities;

public class Message {
	private String message;
	private String type;
	private String cssClass;
	
	// Constructor
	public Message(String message, String type, String cssClass) {
		super();
		this.message = message;
		this.type = type;
		this.cssClass = cssClass;
	}
	
	// Getter and Setter	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCssClass() {
		return cssClass;
	}
	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}
	

}
