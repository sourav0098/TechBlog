function doLike(post_id, user_id) {
	const data = {
		user_id: user_id,
		post_id: post_id
	}
	$.ajax({
		url: "LikeServlet",
		method: "POST",
		data: data,
		success: function(data, textStatus, jqXHR) {
			let counter = $(".like-counter").html();
			if (data.trim() == 'liked') {
				// We have to do this to update like count dynamically on like 
				counter++;
				$(".like-counter").html(counter);
				$(".like-btn").removeClass('fa-regular');
				$(".like-btn").addClass('fa-solid');
			} else if (data.trim() == 'disliked') {
				if (counter > 0) {
					counter--;
				}
				$(".like-counter").html(counter);
				$(".like-btn").removeClass('fa-solid');
				$(".like-btn").addClass('fa-regular');
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log(data);
		}
	})
}

$(document).ready(function() {
	// Comment Form Toggler
	let commentStatus = false;
	$("#comment-btn").on("click", function() {
		if (commentStatus == false) {
			commentStatus = true;
			$("#comment-form").show();
		} else {
			commentStatus = false;
			$("#comment-form").hide();
		}
	})
	
	

	$("#comment-form").on("submit", function(e) {
		e.preventDefault();
		let form = new FormData(this);

		$.ajax({
			url: "CommentServlet",
			method: "POST",
			data: form,
			success: function(data, textStatus, jqXHR) {
				let commentCounter = $(".comment-counter").html();
				
				// Success
				if (data.trim() == 'true') {
					commentCounter++;
					// load comments container again
					$(".comments-container").load(location.href + " .comments-container");

					// hide comment box
					commentStatus = false;
					$('#comment-form').hide();
					$('#comment').val("");
					
					// Update comment count
					$(".comment-counter").html(commentCounter);
				}
				else{
					$(".comments-container").html("<h3 class='text-center'>Unable to retrieve comments.. please try again</h3>");					
				}

			},
			error: function(jqXHR, textStatus, errorThrown) {
				// Error
				$(".comments-container").html("<h3 class='text-center'>Unable to retrieve comments.. please try again</h3>");
			},
			processData: false,
			contentType: false,
			cache: false
		})
	})
})