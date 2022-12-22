<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
<title>Register</title>
</head>
<body>
	<!-- Navbar -->
	<%@include file="navbar.jsp"%>
	<main
		class="d-flex align-items-center justify-content-center flex-column"
		style="height: 90vh;">
		<div class="container w-50">
			<h1>Register</h1>
			<form action="RegisterServlet" method="post" id="reg-form">
				<div class="mb-3">
					<label for="name" class="form-label">Name</label> <input
						type="text" class="form-control" id="name" name="name">
				</div>
				<div class="mb-3">
					<label for="email" class="form-label">Email</label> <input
						type="email" class="form-control" id="email" name="email">
				</div>
				<div class="mb-3">
					<label for="password" class="form-label">Password</label> <input
						type="password" class="form-control" id="password" name="password">
				</div>
				<div class="mb-3">
					<p>Gender</p>
					<input class="form-check-input" type="radio" value="Male"
						name="gender" id="male"> <label
						class="form-check-label me-3" for="male"> Male </label> <input
						class="form-check-input" type="radio" value="Female" name="gender"
						id="female"> <label class="form-check-label" for="female">
						Female </label>
				</div>
				<div class="mb-3">
					<label for="about" class="form-label">Tell us something
						about yourself</label>
					<textarea class="form-control"
						placeholder="Tell us something about yourself" name="about"
						id="about" style="height: 100px"></textarea>
				</div>
				<div class="mb-3 form-check">
					<input type="checkbox" class="form-check-input" id="terms"
						name="terms"> <label class="form-check-label" for="terms">I
						accept terms and conditions</label>
				</div>
				<div class="mb-3 text-center d-none" id="loader">
					<i class="fa-solid fa-sync-alt fa-spin fs-4"></i>
					<p>Please wait...</p>
				</div>
				<button id="submit-btn" type="submit" class="btn btn-primary">Register</button>
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
	<script src="https://code.jquery.com/jquery-3.6.2.min.js"
		integrity="sha256-2krYZKh//PcchRtd+H+VyyQoZ/e3EcrkxhM8ycwASPA="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
		integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
		$(document).ready(function() {
			console.log("Loaded...")
			$("#reg-form").on("submit", function(event) {
				event.preventDefault();

				$("#submit-btn").hide();
				$("loader").show();

				// Getting all data from form
				let form = new FormData(this);

				//Send to Register Servlet
				//Add @MultipartConfig to servlet to make it work with content type false
				$.ajax({
					url : "RegisterServlet",
					type : "POST",
					data : form,
					success : function(data, textStatus, jqXHR) {
						console.log(data);
						$("#submit-btn").show();
						$("loader").hide();
						if(data.trim()=='Done'){							
							swal("Success! you are sucessfully registered")
							.then((value) => {
							  window.location="login.jsp";
							});
						}else{
							swal(data);
						}

					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log(jqXHR);
						$("#submit-btn").show();
						$("loader").hide();
						Swal.fire({
							  icon: 'error',
							  title: 'Oops...',
							  text: 'Something went wrong!'
							})
					},
					processData : false,
					contentType : false
				})
			})
		})
	</script>
</body>
</html>