<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.tech.blog.dao.*"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Comment"%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%
int post_id = Integer.parseInt(request.getParameter("id"));

PostDao postDao1 = new PostDao(ConnectionProvider.getConnection());
Post post = postDao1.getPostById(post_id);
%>
<title>Tech Blog | <%=post.getTitle()%>
</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
	integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<!-- Navbar -->
	<%@include file="navbar.jsp"%>
	<%
	if (user == null) {
		response.sendRedirect("login.jsp");
	}
	%>

	<!-- Main content -->
	<main>
		<div class="container">
			<div class="row mt-4">
				<div class="col-md-10 offset-md-1">
					<div class="card">
						<img src="blog_pics/<%=post.getPost_image()%>"
							class="card-img-top image-fluid"
							style="max-height: 315px; object-fit: cover;" alt="...">
						<div class="card-header">
							<h4><%=post.getTitle()%></h4>
							<div class="row">
								<div class="col-md-8">
									<%
									UserDao userDao = new UserDao(ConnectionProvider.getConnection());
									User userObj = userDao.getUserByUserId(post.getUser_id());
									%>
									<p>
										Posted By: <a href="" style="text-decoration: none;"><%=userObj.getName()%></a>
									</p>
								</div>
								<div class="col-md-4" style="text-align: right;">
									<p><%=DateFormat.getDateInstance().format(post.getCreated_at())%></p>
								</div>
							</div>
						</div>
						<div class="card-body">
							<p><%=post.getContent()%></p>
							<br>
							<pre><%=post.getCode()%></pre>
						</div>

						<%
						LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
						%>

						<div class="card-footer">
							<!-- Likes -->
							<%
							if (likeDao.isLikedByUser(post.getId(), user.getId())) {
							%>
							<!-- If post is liked -->
							<a href="#!"
								onclick="doLike(<%=post.getId()%>,<%=user.getId()%>)"
								class="btn btn-outline-primary btn-sm"> <i
								class="fa-solid fa-thumbs-up me-2 like-btn"></i> <span
								class="like-counter"><%=likeDao.countLike(post.getId())%></span>
							</a>
							<%
							} else {
							%>
							<!-- If post is disliked -->
							<a href="#!"
								onclick="doLike(<%=post.getId()%>,<%=user.getId()%>)"
								class="btn btn-outline-primary btn-sm"> <i
								class="fa-regular fa-thumbs-up me-2 like-btn"></i> <span
								class="like-counter"><%=likeDao.countLike(post.getId())%></span>
							</a>
							<%
							}
							%>

							<!-- Comments -->
							<%
							CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());
							%>

							<a href="#!" id="comment-btn"
								class="btn btn-outline-primary btn-sm"> <i
								class="fa-regular fa-comment me-2"></i><span
								class="comment-counter"><%=commentDao.countCommentsByPost(post.getId())%></span>
							</a>

							<!-- Comment Form -->
							<form action="CommentServlet" method="POST" id="comment-form"
								style="display: none">
								<div class="mb-3 mt-3">
									<input type="hidden" name="user_id" value="<%=user.getId()%>">
									<input type="hidden" name="post_id" value="<%=post.getId()%>">
									<input type="text" class="form-control" id="comment"
										name="comment" placeholder="Add a Comment">
									<button type="submit" class="btn btn-primary mt-3">Submit</button>
								</div>
							</form>
						</div>
					</div>
					<!-- Comments List -->
					<h4 class="mt-3" id="comment-heading">Comments</h4>
					<div class="comments-container">

						<%
						List<Comment> comments = commentDao.getCommentsByPost(post_id);
						for (Comment c : comments) {
						%>

						<div>
							<div class="d-flex justify-content-between">
								<%
								User obj1 = userDao.getUserByUserId(c.getUser_id());
								%>
								<a href="#!" style="text-decoration: none"><%=obj1.getName()%></a>
								<p><%=DateFormat.getDateTimeInstance().format(c.getCreated_at())%></p>
							</div>
							<div>
								<p><%=c.getComment()%></p>
							</div>
							<hr>
						</div>

						<%
						}
						%>
						<%
						if (comments.size() == 0) {
						%>
						<h3 class="text-center mb-4">No comments Found</h3>
						<%
						}
						%>
					</div>

				</div>
			</div>
		</div>
	</main>

	<!-- Profile Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header primary-background text-white">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Profile</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfile()%>" style="max-width: 86px;"
							class="img-fluid" alt="">

						<!-- Profile Details-->
						<div id="profile-details">
							<h5><%=user.getName()%></h5>
							<table class="table table-borderless">
								<tbody>
									<tr>
										<th scope="row">Email:</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">About:</th>
										<td><%=user.getAbout()%></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>

					<!-- Profile Edit-->
					<div id="profile-edit" style="display: none;">
						<form action="EditServlet" method="POST"
							enctype="multipart/form-data">
							<table class="table table-borderless">
								<tbody>
									<tr>
										<th scope="row">Update Image</th>
										<td><input type="file" class="form-control" name="image"
											accept="image/png, image/gif, image/jpeg"
											value="<%=user.getProfile()%>"></td>
									</tr>
									<tr>
										<th scope="row">Name:</th>
										<td><input type="text" class="form-control" name="name"
											value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><input type="email" class="form-control" name="email"
											value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><input class="form-check-input" type="radio"
											value="Male" name="gender" id="male"
											<%=user.getGender().equals("Male") ? "checked" : ""%>>
											<label class="form-check-label me-3" for="male"> Male
										</label> <input class="form-check-input" type="radio" value="Female"
											<%=user.getGender().equals("Female") ? "checked" : ""%>
											name="gender" id="female"> <label
											class="form-check-label" for="female"> Female </label></td>
									</tr>
									<tr>
										<th scope="row">About:</th>
										<td><textarea class="form-control"
												placeholder="Tell us something about yourself" name="about"
												id="about" style="height: 100px"><%=user.getAbout()%></textarea>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="container" style="text-align: right;">
								<input type="submit" class="btn btn-success" value="Update">
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" id="edit-btn" class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
		integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
		integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.2.min.js"
		integrity="sha256-2krYZKh//PcchRtd+H+VyyQoZ/e3EcrkxhM8ycwASPA="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
		integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script type="text/javascript" src="js/like.js"></script>
	<script type="text/javascript" src="js/app.js"></script>
</body>
</html>