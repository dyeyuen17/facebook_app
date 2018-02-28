defmodule FacebookAppWeb.ProfileController do
  use FacebookAppWeb, :controller

  alias FacebookApp.Accounts
  alias FacebookApp.Accounts.Profile

  action_fallback FacebookAppWeb.FallbackController

  def index(conn, _params) do
    profiles = Accounts.list_profiles()
    render(conn, "index.json", profiles: profiles)
  end

  def create_profile(conn, %{"profile" => profile_params}) do
    user = conn.assigns.current_user
    with {:ok, %Profile{} = profile} <- Accounts.create_profile(profile_params, user) do
      conn
      |> put_status(:created)
      |> render("show.json", profile: profile)
    end
  end

  def get_user_profile(conn, _params) do
    user = conn.assigns.current_user
    profile = Accounts.get_users_profile!(user)
    render(conn, "users_profile.json", profile: profile, user: user)
  end

  def update(conn, %{"id" => id, "profile" => profile_params}) do
    profile = Accounts.get_profile!(id)

    with {:ok, %Profile{} = profile} <- Accounts.update_profile(profile, profile_params) do
      render(conn, "show.json", profile: profile)
    end
  end

  def delete(conn, %{"id" => id}) do
    profile = Accounts.get_profile!(id)
    with {:ok, %Profile{}} <- Accounts.delete_profile(profile) do
      send_resp(conn, :no_content, "")
    end
  end
end
