defmodule FacebookAppWeb.PostController do
  use FacebookAppWeb, :controller

  alias FacebookApp.Actions
  alias FacebookApp.Actions.Post

  action_fallback FacebookAppWeb.FallbackController

  def index(conn, _params) do
    posts = Actions.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Actions.create_post(post_params, conn.assigns.current_user) do
      conn
      |> put_status(:created)
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Actions.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Actions.get_post!(id)
    with {:ok, %Post{} = post} <- Actions.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Actions.get_post!(id)
    with {:ok, %Post{}} <- Actions.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
