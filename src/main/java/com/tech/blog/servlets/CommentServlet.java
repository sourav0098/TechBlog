package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.CommentDao;
import com.tech.blog.entities.Comment;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/CommentServlet")
@MultipartConfig
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CommentServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		int user_id = Integer.parseInt(request.getParameter("user_id"));
		int post_id = Integer.parseInt(request.getParameter("post_id"));
		String comment = request.getParameter("comment");

		Comment c = new Comment(user_id, post_id, comment);
		CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());
		boolean result = commentDao.AddComment(c);
		if (result == true) {
			out.println("true");
		} else {
			out.println("false");
		}
	}
}