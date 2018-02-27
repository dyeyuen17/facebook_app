defmodule FacebookApp.Actions.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias FacebookApp.Actions.Comment
  alias FacebookApp.Accounts.User
  alias FacebookApp.Actions.Post

  schema "comments" do
    field :content, :string
    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
    |> assoc_constraint(:user)
    |> assoc_constraint(:post)
  end
end
