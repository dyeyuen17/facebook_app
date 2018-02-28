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
      resources("/reactions", ReactionController, except: [:new, :edit])
    end

    resources "/profile", ProfileController, except: [:new, :edit, :create]

    get "/logout", UserController, :logout
    get "/users", UserController, :index

  end

end
