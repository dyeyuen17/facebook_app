defmodule FacebookAppWeb.ReactionView do
  use FacebookAppWeb, :view
  alias FacebookAppWeb.ReactionView

  def render("index.json", %{reactions: reactions}) do
    %{data: render_many(reactions, ReactionView, "reaction.json")}
  end

  def render("show.json", %{reaction: reaction}) do
    %{data: render_one(reaction, ReactionView, "reaction.json")}
  end

  def render("reaction.json", %{reaction: reaction}) do
    %{id: reaction.id,
      reaction: reaction.reaction}
  end
end
