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

  end

  scope "/api", FacebookAppWeb do
    pipe_through [:api, :authentication]
    resources("/posts", PostController, except: [:new, :edit]) do
      resources("/comments", CommentController, except: [:new, :edit])
    end

    post "/profile", ProfileController, :create_profile
    post "/:post_id/react", ReactionController, :react

    get "/my/profile", ProfileController, :get_user_profile
    get "/logout", UserController, :logout

    get "/users", UserController, :index
  end

end
