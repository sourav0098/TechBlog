package com.tech.blog.servlets;

import com.tech.blog.entities.User;
import com.tech.blog.entities.Message;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tech.blog.dao.UserDao;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
//		PrintWriter out=response.getWriter();
		
		// Fetch username and password from request
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		
		UserDao userDao=new UserDao(ConnectionProvider.getConnection());
		
		// Get user object from userdao function		
		User user=userDao.getUserByEmailandPassword(email, password);
		if(user==null) {
			// Invalid credentials
			Message msg=new Message("Invalid Credentials Please try again...","Error","alert-danger");
			HttpSession session=request.getSession();
			session.setAttribute("msg",msg);
			response.sendRedirect("login.jsp");
			
		}else {
			// Store in session
			HttpSession session=request.getSession();
			session.setAttribute("user",user);
			response.sendRedirect("profile.jsp");
		}
	}

}
