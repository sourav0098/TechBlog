<%@page import="com.tech.blog.helper.TruncateStringHelper"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.*"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>


<%
User user = (User) session.getAttribute("user");
%>
<div class="row">
	<%
	//Delete the below line before deployment(for testing purpose only)
	Thread.sleep(1000);

	PostDao postDao = new PostDao(ConnectionProvider.getConnection());

	// Getting category_id from ajax
	int category_id = Integer.parseInt(request.getParameter("category_id"));
	List<Post> posts = null;

	if (category_id == 0) {
		posts = postDao.getAllPosts();
	} else {
		posts = postDao.getPostByCategory(category_id);
	}

	// No posts for specific category
	if (posts.size() == 0) {
		out.println("<h3 class='text-center mt-3'>No posts found!<h3>");
		return;
	}

	for (Post p : posts) {
	%>
	<div class="col-md-6">
		<div class="card mb-3">
			<img src="blog_pics/<%=p.getPost_image()%>"
				class="card-img-top image-fluid"
				style="max-height: 200px; object-fit: cover;" alt="...">
			<div class="card-body" style="height: 270px;">
				<b><%=TruncateStringHelper.abbreviateString(p.getTitle(),150)%></b>
				<p><%=TruncateStringHelper.abbreviateString(p.getContent(),350)%></p>
			</div>
			<div class="card-footer d-flex justify-content-between">
				<div>
					<a href="blog_post.jsp?id=<%=p.getId()%>"
						class="btn btn-outline-primary btn-sm">Read More...</a>
				</div>
				<%
				LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
				CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());
				%>
				<div class="d-flex align-items-center">
					<!-- Like Btn -->
					<%
					if (likeDao.isLikedByUser(p.getId(), user.getId())) {
					%>
					<p class="text-primary pe-0 btn-sm mb-0"
						style="cursor: default;"><i class="fa-solid fa-thumbs-up me-2"></i><span><%=likeDao.countLike(p.getId())%></span></p>
					<%
					} else {
					%>
					<p class="text-primary pe-0 btn-sm mb-0"
						style="cursor: default;"><i
						class="fa-regular fa-thumbs-up me-2"></i><span><%=likeDao.countLike(p.getId())%></span></p>
					<%
					}
					%>
					<!-- Comment Btn -->
					<a href="blog_post.jsp?id=<%=p.getId()%>#comment"
						class="btn text-primary pe-0 cursor-none btn-sm"
						style="cursor: default;"><i class="fa-regular fa-comment me-2"></i><span><%=commentDao.countCommentsByPost(p.getId())%></span></a>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	%>
</div>
