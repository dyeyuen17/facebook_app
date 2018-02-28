defmodule FacebookAppWeb.Router do
  use FacebookAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authentication do
    plug FacebookAppWeb.Helpers.Plugs.AuthPipeline
    plug FacebookAppWeb.Helpers.Plugs.CurrentUser
  end

  scope "/api", FacebookAppWeb do
    pipe_through :api

    post "/login", UserController, :login
    post "/register", UserController, :register
    get "/users", UserController, :index
    get "/posts", PostController, :index

  end

  scope "/api", FacebookAppWeb do
    pipe_through [:api, :authentication]

    post "/profile", ProfileController, :create_profile
    post "/post", PostController, :create_post
    post "/:post_id/comment", CommentController, :create_comment
    post "/:post_id/react", ReactionController, :react

    get "/my/profile", ProfileController, :get_user_profile
    get "/my/posts", PostController, :get_user_posts
    get "/posts/comments", CommentController, :get_post_comments
    get "/posts/reactions", ReactionController, :get_post_reactions

    get "/logout", UserController, :logout

  end

end
