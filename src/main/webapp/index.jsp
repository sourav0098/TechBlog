<%@page import="com.tech.blog.helper.TruncateStringHelper"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">
<title>Home Page</title>
</head>
<body>
	<!-- Navbar -->
	<%@include file="navbar.jsp"%>

	<div class="p-5 mb-4 bg-light rounded-3">
		<div class="container-fluid py-5">
			<h1 class="display-5 fw-bold">Welcome Friends</h1>
			<p class="col-md-8 fs-4">Welcome to Tech Blog</p>

			<%
			if (user == null) {
			%>
			<a href="login.jsp"><button class="btn btn-primary" type="button">Login</button></a>
			<a href="register.jsp"><button class="btn btn-primary"
					type="button">Register</button></a>
			<%
			}
			%>
		</div>
	</div>

	<!-- Cards -->
	<div class="container">
		<h1 class="mb-3">Latest Posts</h1>
		<div class="row mb-4">

			<%
			PostDao postDao = new PostDao(ConnectionProvider.getConnection());
			List<Post> posts = postDao.getLatestPosts();

			for (Post p : posts) {
			%>
			<div class="col-md-4">
				<div class="card mb-3">
					<div class="card-body" style="height: 180px">
						<h6 class="card-title"><%=p.getTitle()%></h6>
						<p class="card-text"><%=TruncateStringHelper.abbreviateString(p.getContent(), 150)%></p>
					</div>
					<div class="card-footer">
						<a href="blog_post.jsp?id=<%=p.getId()%>" class="btn btn-primary">Read More</a>
					</div>
				</div>
			</div>

			<%
			}
			%>

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
</html>