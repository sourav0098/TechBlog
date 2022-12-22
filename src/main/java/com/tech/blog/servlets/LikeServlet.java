package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class LikeServlet
 */
@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LikeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String operation = request.getParameter("operation");
		int user_id = Integer.parseInt(request.getParameter("user_id"));
		int post_id = Integer.parseInt(request.getParameter("post_id"));

		LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());

		// If user liked the posted then delete the like otherwise add like
		if(!likeDao.isLikedByUser(post_id, user_id)) {			
			boolean result = likeDao.addLike(post_id,user_id);
			if (result) {
				out.println("liked");
			} else {
				out.println("false");
			}
		}else {			
			boolean result = likeDao.deleteLike(post_id,user_id);
			if (result) {
				out.println("disliked");
			} else {
				out.println("false");
			}
		}
	}
}