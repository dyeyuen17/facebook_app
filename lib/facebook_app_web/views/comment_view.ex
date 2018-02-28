defmodule FacebookAppWeb.CommentView do
  use FacebookAppWeb, :view
  alias FacebookAppWeb.CommentView
  alias FacebookAppWeb.UserView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      content: comment.content,
      user: render_one(comment.user, UserView, "user.json")}
  end

  def render("post_comment.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end
end
