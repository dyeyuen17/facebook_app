defmodule FacebookAppWeb.UserView do
  use FacebookAppWeb, :view
  alias FacebookAppWeb.UserView
  alias FacebookAppWeb.PostView
  alias FacebookAppWeb.ProfileView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "users.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      password: user.password,
      profile: render_one(user.profile, ProfileView, "profile.json")
    }
  end

  def render("users.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      posts: render_many(user.posts, PostView, "post.json"),
      profile: render_one(user.profile, ProfileView, "profile.json")
    }
  end

  def render("auth.json", %{user: user, token: token}) do
    %{email: user.email,
      token: token
    }
  end

end
