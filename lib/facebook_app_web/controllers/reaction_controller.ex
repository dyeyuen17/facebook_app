defmodule FacebookAppWeb.ReactionController do
  use FacebookAppWeb, :controller

  alias FacebookApp.Actions
  alias FacebookApp.Actions.Reaction

  action_fallback FacebookAppWeb.FallbackController

  def index(conn, _params) do
    reactions = Actions.list_reactions()
    render(conn, "index.json", reactions: reactions)
  end

  def create(conn, %{"reaction" => reaction_params}) do
    with {:ok, %Reaction{} = reaction} <- Actions.create_reaction(reaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", reaction_path(conn, :show, reaction))
      |> render("show.json", reaction: reaction)
    end
  end

  def show(conn, %{"id" => id}) do
    reaction = Actions.get_reaction!(id)
    render(conn, "show.json", reaction: reaction)
  end

  def update(conn, %{"id" => id, "reaction" => reaction_params}) do
    reaction = Actions.get_reaction!(id)

    with {:ok, %Reaction{} = reaction} <- Actions.update_reaction(reaction, reaction_params) do
      render(conn, "show.json", reaction: reaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    reaction = Actions.get_reaction!(id)
    with {:ok, %Reaction{}} <- Actions.delete_reaction(reaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
