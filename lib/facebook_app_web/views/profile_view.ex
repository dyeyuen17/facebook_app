defmodule FacebookAppWeb.ProfileView do
  use FacebookAppWeb, :view
  alias FacebookAppWeb.ProfileView

  def render("index.json", %{profiles: profiles}) do
    %{data: render_many(profiles, ProfileView, "profile.json")}
  end

  def render("show.json", %{profile: profile}) do
    %{data: render_one(profile, ProfileView, "profile.json")}
  end

  def render("profile.json", %{profile: profile}) do
    %{
      id: profile.id,
      first_name: profile.first_name,
      last_name: profile.last_name,
      avatar: profile.avatar
    }
  end

  def render("user_profile.json", %{profile: [profile] , user: user}) do
    %{data: render_one(profile, user, ProfileView, "users_profile.json")}
  end

  def render("users_profile.json", %{profile: [profile], user: user}) do
    %{id: profile.id,
      first_name: profile.first_name,
      last_name: profile.last_name,
      avatar: profile.avatar,
      email: user.email
    }
  end
end
