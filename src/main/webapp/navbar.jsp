<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@ page import="com.tech.blog.entities.*"%>
<%@ page import="com.tech.blog.dao.PostDao"%>
<%@page import="java.util.ArrayList"%>

<%
User user = (User) session.getAttribute("user");
%>

<nav class="navbar navbar-expand-lg primary-background">
	<div class="container-fluid">
		<a class="navbar-brand text-white" href="index.jsp">Tech Blog</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link active text-white"
					aria-current="page" href="profile.jsp">Posts</a></li>
				<li class="nav-item"><a class="nav-link text-white">About
						Us</a></li>
				<li class="nav-item"><a class="nav-link text-white" href="#">Contact
						Us</a></li>
			</ul>
		</div>
	</div>
	<div>
		<ul class="navbar-nav me-auto mb-2 mb-lg-0 align-items-center">
			<%
			if (user == null) {
			%>
			<li class="nav-item"><a class="nav-link active text-white"
				aria-current="page" href="login.jsp">Login</a></li>
			<li class="nav-item"><a class="nav-link active text-white"
				aria-current="page" href="register.jsp">Register</a></li>
			<%
			} else {
			%>
			<li class="nav-item text-white" style="cursor: pointer;"
				data-bs-toggle="modal" data-bs-target="#profile-modal"><i
				class="fa-solid fa-user-circle d-inline me-2"></i><%=user.getName()%></li>
			<li class="nav-item"><a class="nav-link active text-white"
				aria-current="page" href="LogoutServlet">Logout</a></li>
			<%
			}
			%>
		</ul>
	</div>
</nav>