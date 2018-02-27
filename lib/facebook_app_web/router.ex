defmodule FacebookAppWeb.Router do
  use FacebookAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authentication do

  end

  scope "/api", FacebookAppWeb do
    pipe_through :api

    post "/login", UserController, :login
    post "/register", UserController, :register

  end

  scope "/api", FacebookAppWeb do
    pipe_through [:api, :authentication]

    post "/profile", ProfileController, :create_profile
    get "/profiles", ProfileController, :get_user_profile
    post "/post", PostController, :create_post
    get "/posts", PostController, :get_user_posts
    post "/comment", CommentController, :create_comment
    get "/comments", CommentController, :get_post_comments
    post "/react", ReactionController, :react
    get "/reactions", ReactionController, :get_post_reactions

  end

end
