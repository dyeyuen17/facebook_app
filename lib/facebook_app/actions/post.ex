defmodule FacebookApp.Actions.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias FacebookApp.Actions.Post
  alias FacebookApp.Accounts.User
  alias FacebookApp.Actions.Comment
  alias FacebookApp.Actions.Reaction


  schema "posts" do
    field :content, :string
    belongs_to :user, User
    has_many :comments, Comment
    has_many :reactions, Reaction

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:content])
    |> validate_required([:content])
    |> assoc_constraint(:user)
  end
end
