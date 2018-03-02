defmodule FacebookAppWeb.ReactionController do
  use FacebookAppWeb, :controller

  alias FacebookApp.Actions
  alias FacebookApp.Actions.Reaction

  action_fallback FacebookAppWeb.FallbackController

  def index(conn, _params) do
    reactions = Actions.list_reactions()
    render(conn, "index.json", reactions: reactions)
  end

  def create(conn, %{"reaction" => reaction_params, "post_id" => post_id}) do
    user = conn.assigns.current_user
    id = post_id |> String.to_integer
    post = Actions.get_post!(id)

    reactions = Actions.get_users_reacted(id)


    cond do
      Enum.empty?([post.reactions]) ->
        with {:ok, %Reaction{} = reaction} <- Actions.create_reaction(reaction_params, user, id) do
          conn
          |> put_status(:created)
          |> render("show.json", reaction: reaction)
        end
      Enum.member?(reactions, user.id) ->
        reaction = Actions.get_reaction_by_user_post(user, id)

        with {:ok, %Reaction{} = reaction} <- Actions.update_reaction(reaction, reaction_params) do
          render(conn, "show.json", reaction: reaction)
        end
    end


    # require IEx
    # IEx.pry()

  end

  def show(conn, %{"post_id" => post_id, "id" => _id}) do
    id = post_id |> String.to_integer
    reactions = Actions.get_posts_reaction!(id)
    render(conn, "post_reaction.json", reactions: reactions)
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
