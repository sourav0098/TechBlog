package com.tech.blog.servlets;

import java.io.Console;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.ImageHelper;

/**
 * Servlet implementation class EditServlet
 */
@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditServlet() {
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
		// Fetch all data from request
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String about = request.getParameter("about");

		// To get image from form
		Part part = request.getPart("image");
		String imageName = part.getSubmittedFileName();

		// Get the user from session and update its values
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		user.setName(name);
		user.setEmail(email);
		user.setGender(gender);
		user.setAbout(about);
		
		// Getting old image path so that we can delete it later
		String oldImage=user.getProfile();
		
		user.setProfile(imageName);

		// Update the data in DB using user object
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		boolean result = userDao.updateUser(user);
		if (result == false) {
			// Error
			Message msg = new Message("Unable to update profile.. please try again", "Error", "alert-danger");
			session.setAttribute("msg", msg);
			response.sendRedirect("profile.jsp");
		} else {
			@SuppressWarnings("deprecation")
			// Delete old image			
			String oldImagePath = request.getRealPath("/") + "pics" + File.separator + oldImage;
			if(!oldImage.equals("default.png")) {				
				ImageHelper.deleteFile(oldImagePath);
			}
			
			@SuppressWarnings("deprecation")
			String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();
			
			if (ImageHelper.saveFile(part.getInputStream(), path)) {
				Message msg = new Message("Profile updated successfully", "Success", "alert-success");
				session.setAttribute("msg", msg);
				response.sendRedirect("profile.jsp");
			} else {
				Message msg = new Message("Unable to update profile picture.. please try again", "Error",
						"alert-danger");
				session.setAttribute("msg", msg);
				response.sendRedirect("profile.jsp");
			}
		}
	}

}
