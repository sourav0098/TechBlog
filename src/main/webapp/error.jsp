<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sorry! Something went wrong</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
</head>
<body>
	<div class="container text-center mt-4">
		<img src="images/error.png" class="image-fluid">
		<h3 class="display-3">Sorry! Something went wrong</h3>
		<%=exception %>
		<a href="index.jsp" class="btn btn-primary">Home</a>
	</div>
</body>
</html>