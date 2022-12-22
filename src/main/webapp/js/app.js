// Get posts by category or all posts
function getPosts(category_id, temp) {
	// Remove active link from sidebar
	$(".c-link").removeClass('active');

	// Show loader and hide container
	$("#loader").show();
	$("#post-container").hide();

	// Ajax request to load_page.jsp
	$.ajax({
		url: "load_post.jsp",
		data: { category_id: category_id },
		type: "GET",
		success: function(data, textStatus, jqXHR) {
			$("#loader").hide();
			$("#post-container").show();
			$("#post-container").html(data);

			// Add active link on category clicked
			$(temp).addClass('active');
		}
	})
}

$(document).ready(function() {
	// Post Modal
	let editStatus = false;
	$("#edit-btn").click(function() {
		if (editStatus == false) {
			$("#profile-details").hide();
			$("#profile-edit").show();
			$(this).text("Cancel");
			editStatus = true;
		} else {
			$("#profile-details").show();
			$("#profile-edit").hide();
			$(this).text("Edit")
			editStatus = false;
		}
	})
	
	// To make all posts active intially
	let allPostsReference = $('.c-link')[0];
	getPosts(0, allPostsReference);

	// Add Post JavaScript
	$("#add-post-form").on("submit", function(e) {
		e.preventDefault();
		// Get form data
		let form = new FormData(this);
		// Ajax request to server		
		$.ajax({
			url: "AddPostServlet",
			type: "POST",
			data: form,
			success: function(data, textStatus, jqXHR) {
				// Success
				if (data.trim() == 'done') {
					swal("Good job!", "Post added successfully", "success");
					$("#all-posts").click();
					$("#post-container").load(location.href + " #post-container");
				} else {
					swal("Error!", "Unable to add post... please try again", "error");
				}
				// hide modal
				$("#addPostModal").modal('toggle');
			},
			error: function(jqXHR, textStatus, errorThrown) {
				// Error
				swal("Error!", "Unable to add post... please try again", "error");
			},
			processData: false,
			contentType: false

		})
	})
})