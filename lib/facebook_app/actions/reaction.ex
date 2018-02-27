defmodule FacebookApp.Actions.Reaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias FacebookApp.Actions.Reaction
  alias FacebookApp.Actions.Post
  alias FacebookApp.Accounts.User

  schema "reactions" do
    field :reaction, :string
    belongs_to :post, Post
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Reaction{} = reaction, attrs) do
    reaction
    |> cast(attrs, [:reaction])
    |> validate_required([:reaction])
    |> assoc_constraint(:user)
    |> assoc_constraint(:post)
  end
end