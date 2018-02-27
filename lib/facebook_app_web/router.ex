defmodule FacebookAppWeb.Router do
  use FacebookAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FacebookAppWeb do
    pipe_through :api
  end
end
