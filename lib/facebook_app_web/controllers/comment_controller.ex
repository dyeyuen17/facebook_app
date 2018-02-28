defmodule FacebookAppWeb.CommentController do
  use FacebookAppWeb, :controller

  alias FacebookApp.Actions
  alias FacebookApp.Actions.Comment

  action_fallback FacebookAppWeb.FallbackController

  def index(conn, _params) do
    comments = Actions.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    user = conn.assigns.current_user
    id = post_id |> String.to_integer
    with {:ok, %Comment{} = comment} <- Actions.create_comment(comment_params, id, user) do
      conn
      |> put_status(:created)
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"post_id" => post_id}) do
    id = post_id |> String.to_integer
    comments = Actions.get_posts_commment!(id)
    render(conn, "post_comment.json", comments: comments)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Actions.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Actions.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Actions.get_comment!(id)
    with {:ok, %Comment{}} <- Actions.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
