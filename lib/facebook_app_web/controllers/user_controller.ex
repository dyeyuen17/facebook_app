defmodule FacebookAppWeb.UserController do
  use FacebookAppWeb, :controller

  alias FacebookApp.Accounts
  alias FacebookApp.Accounts.User

  action_fallback FacebookAppWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def register(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def login(conn, %{"user" => user_params}) do
    user = Accounts.get_user_by_email(user_params["email"])
    case Comeonin.Bcrypt.checkpw(user_params["password"], user.password) do
      true ->
        {:ok, token, _claims} = FacebookAppWeb.Helpers.Plugs.Guardian.encode_and_sign(user)
        render(conn, "auth.json", user: user, token: token)
    end
  end

  def logout(conn, _params) do
    FacebookAppWeb.Helpers.Plugs.Guardian.Plug.sign_out(conn)
    send_resp(conn, :no_content, "")
  end

end
