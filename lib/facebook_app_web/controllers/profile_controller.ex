defmodule FacebookAppWeb.ProfileController do
  use FacebookAppWeb, :controller

  alias FacebookApp.Accounts
  alias FacebookApp.Accounts.Profile
  alias FacebookApp.Accounts.Idcon

  action_fallback FacebookAppWeb.FallbackController

  def index(conn, _params) do
    profiles = Accounts.list_profiles()
    render(conn, "index.json", profiles: profiles)
  end

  def show(conn, _params) do
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

  def upload(conn, %{"upload" => upload}) do
    user = conn.assigns.current_user
    [h | _t] = Accounts.get_users_profile!(user)
    filename = Idcon.hash_name(user.email)

    extension = Path.extname(upload.filename)
    destination = "media/avatar/#{filename}#{extension}"
    File.rm(h.avatar)
    File.cp(upload.path, destination)

    Accounts.update_profile(h, %{avatar: destination})
    render(conn, "show.json", profile: h)

  end
end
