defmodule FacebookAppWeb.PostController do
  use FacebookAppWeb, :controller

  alias FacebookApp.Actions
  alias FacebookApp.Actions.Post
  alias FacebookApp.Accounts

  action_fallback FacebookAppWeb.FallbackController

  def index(conn, _params) do
    posts = Actions.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create_post(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Actions.create_post(post_params, conn.assigns.current_user) do
      conn
      |> put_status(:created)
      |> render("show.json", post: post)
    end
  end

  def get_user_posts(conn, _) do
    user = conn.assigns.current_user
    posts = Actions.get_users_post!(user)
    render(conn, "user_posts.json", posts: posts)
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
