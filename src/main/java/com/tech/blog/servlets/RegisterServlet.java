package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out=response.getWriter();
		String terms=request.getParameter("terms");
		if(terms==null) {
			// Send error to check terms and conditions
			out.println("Please accept terms and conditions");
		}else {			
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String password=request.getParameter("password");
			String gender=request.getParameter("gender");
			String about=request.getParameter("about");
			
			//Create user object and pass object to UserDao
			User user=new User(name,email,password,gender,about);
			
			// Create a UserDao object
			UserDao userDao=new UserDao(ConnectionProvider.getConnection());
			if(userDao.registerUser(user)){
				out.println("Done");
			}else {
				out.println("Something went wrong! ");			
			}
			
			
		}
	}

}
