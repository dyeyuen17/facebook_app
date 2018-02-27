defmodule FacebookApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FacebookApp.Accounts.User
  alias FacebookApp.Accounts.Profile
  alias FacebookApp.Actions.Post
  alias FacebookApp.Actions.Reaction
  alias FacebookApp.Actions.Comment

  schema "users" do
    field :email, :string, null: false
    field :password, :string
    has_many :posts, Post
    has_many :reactions, Reaction
    has_many :comments, Comment
    has_one :profile, Profile

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/\S+@\S+\.\S{1,4}+/)
    |> unique_constraint(:email)
    |> hash_password
  end

  def hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

end
