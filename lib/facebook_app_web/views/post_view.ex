defmodule FacebookAppWeb.PostView do
  use FacebookAppWeb, :view
  alias FacebookAppWeb.PostView
  alias FacebookAppWeb.CommentView
  alias FacebookAppWeb.ReactionView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do

    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    # require IEx
    # IEx.pry()
    %{id: post.id,
      user_id: post.user_id,
      content: post.content,
      comments: render_many(post.comments, CommentView, "comment.json"),
      reactions: render_many(post.reactions, ReactionView, "reaction.json")
    }
  end

  def render("user_posts.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

end
