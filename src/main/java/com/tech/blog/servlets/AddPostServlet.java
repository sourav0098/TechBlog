package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.ImageHelper;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddPostServlet() {
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
		PrintWriter out=response.getWriter();
		int category_id = Integer.parseInt(request.getParameter("category_id"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String code = request.getParameter("code");

		//Get image
		Part part = request.getPart("post_image");
		String post_image = part.getSubmittedFileName();

		// Get user_id
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		int user_id = user.getId();

		Post post = new Post(category_id, user_id, title, content, code, post_image);

		PostDao postDao = new PostDao(ConnectionProvider.getConnection());
		boolean result=postDao.addPost(post);
		if (result==true) {
			// Success (Add image to file system)
			@SuppressWarnings("deprecation")
			String path = request.getSession().getServletContext().getRealPath("/") + "blog_pics" + File.separator + part.getSubmittedFileName();
			if(ImageHelper.saveFile(part.getInputStream(), path)){
				out.println("done");
			}else {
				// Error
				out.println("error");
			}
		} else {
			// Error
			out.println("error");
		}
	}
}
