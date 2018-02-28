defmodule FacebookAppWeb.CommentView do
  use FacebookAppWeb, :view
  alias FacebookAppWeb.CommentView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      content: comment.content}
  end

  def render("post_comment.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end
end
