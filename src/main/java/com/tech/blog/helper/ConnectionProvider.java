package com.tech.blog.helper;
import java.sql.*;
public class ConnectionProvider {
	private static final String USERNAME="root";
	private static final String PASSWORD="123456";
	private static Connection conn;
	
	public static Connection getConnection() {
		try {
			if(conn==null) {				
				// Load Driver
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				// Create a connection
				conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog",USERNAME,PASSWORD);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
}
