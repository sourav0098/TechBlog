<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.tech.blog.entities.*"%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<!-- Navbar -->
	<%@include file="navbar.jsp"%>
	
	<!-- Alert -->
	<% 
		Message msg=(Message)session.getAttribute("msg"); 
		if(msg!=null){
	
	%>
		<div class="alert <%=msg.getCssClass()%> alert-dismissible fade show"
			role="alert">
			<strong><%=msg.getType()%>! </strong><%= msg.getMessage()%>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>	
	<% 
		// to remove msg from session so that it does not show alert after reload
		session.removeAttribute("msg");
		}
	%>
	
	<% if(user!=null){
		response.sendRedirect("/TechBlog");
	} %>
	
	
	<main
		class="d-flex align-items-center justify-content-center flex-column"
		style="height: 60vh;">
		<div class="container w-25">
			<h1>Login</h1>
			<form action="LoginServlet" method="POST">
				<div class="mb-3">
					<label for="email" class="form-label">Email</label> <input
						type="email" class="form-control" id="email" name="email" required>
				</div>
				<div class="mb-3">
					<label for="password" class="form-label">Password</label> <input
						type="password" class="form-control" id="password" name="password"
						required>
				</div>
				<button type="submit" class="btn btn-primary">Login</button>
			</form>
		</div>
	</main>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
		integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
		integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
		crossorigin="anonymous"></script>
</body>
</html>