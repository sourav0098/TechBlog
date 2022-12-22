
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.tech.blog.entities.*"%>
<%@ page errorPage="error.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
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
	<!-- Alert -->
	<%
	Message msg = (Message) session.getAttribute("msg");
	if (msg != null) {
	%>
	<div class="alert <%=msg.getCssClass()%> alert-dismissible fade show"
		role="alert">
		<strong><%=msg.getType()%>!
		</strong><%=msg.getMessage()%>
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	session.removeAttribute("msg");
	}
	%>

	<!-- Main Body -->
	<main>
		<div class="container mt-3" style="text-align: right">
			<%
				if (user != null) {
				%>
				<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPostModal">Add a Post</button>
				<%
				}
				%>
		</div>
		<div class="container">
			<div class="row mt-4">
				<!-- Sidebar -->
				<div class="col-md-3">
					<div class="list-group">
						<!-- on click calling the ajax function to get posts -->
						<a href="#" onclick="getPosts(0,this)"
							class="list-group-item list-group-item-action c-link"
							aria-current="true" id="all-posts"> All Posts </a>

						<!-- Categories -->
						<%

						PostDao postDao = new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> categories = postDao.getAllCategories();
						
						for (Category c : categories) {
						%>
						<!-- on click calling the ajax function to get posts -->
						<a href="#" onclick="getPosts(<%=c.getId()%>,this)"
							class="list-group-item list-group-item-action c-link"><%=c.getName()%></a>
						<%
						}
						%>
					</div>
				</div>

				<!-- Latest Posts -->
				<div class="col-md-9">
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>
					<div class="container-fluid" id="post-container">
						
						<!-- Getting posts through ajax -->					
						
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
										<td>
											<input type="file" class="form-control" name="image"
												accept="image/png, image/gif, image/jpeg"
												value="<%=user.getProfile()%>">
										</td>
									</tr>
									<tr>
										<th scope="row">Name:</th>
										<td>
											<input type="text" class="form-control" name="name"
												value="<%=user.getName()%>">
										</td>
									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td>
											<input type="email" class="form-control" name="email"
												value="<%=user.getEmail()%>">
										</td>
									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td>
											<input class="form-check-input" type="radio" value="Male"
												name="gender" id="male"
												<%=user.getGender().equals("Male") ? "checked" : ""%>>
											<label class="form-check-label me-3" for="male"> Male
											</label>
											<input class="form-check-input" type="radio" value="Female"
												<%=user.getGender().equals("Female") ? "checked" : ""%>
												name="gender" id="female">
											<label class="form-check-label" for="female"> Female
											</label>
										</td>
									</tr>
									<tr>
										<th scope="row">About:</th>
										<td>
											<textarea class="form-control"
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

	<!-- Add a Post Modal -->
	<div class="modal fade" id="addPostModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Add a Post</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="AddPostServlet" method="POST" id="add-post-form"
						enctype='multipart/form-data'>
						<div class="mb-3">
							<p class="form-label">Category</p>
							<select class="form-select" name="category_id">
								<option disabled selected>Select a category</option>

								<!-- Getting categories from DB -->
								<%
								PostDao postdao = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = postdao.getAllCategories();

								for (Category c : list) {
								%>
								<option value="<%=c.getId()%>"><%=c.getName()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="mb-3">
							<label for="post_image" class="form-label">Upload post
								image</label>
							<input class="form-control" type="file" id="post_image"
								accept="image/png, image/gif, image/jpeg" name="post_image">
						</div>
						<div class="mb-3">
							<label for="title" class="form-label">Title</label>
							<input type="text" class="form-control" id="title"
								aria-describedby="emailHelp" name="title">
						</div>
						<div class="mb-3">
							<label for="content" class="form-label">Add Content</label>
							<textarea class="form-control" id="content" name="content"
								style="height: 100px"></textarea>
						</div>
						<div class="mb-3">
							<label for="code" class="form-label">Add Code(if any)</label>
							<textarea class="form-control" id="code" name="code"
								style="height: 100px"></textarea>
						</div>
						<button type="submit" class="btn btn-success">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
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
<script type="text/javascript" src="js/app.js"></script>
</html>