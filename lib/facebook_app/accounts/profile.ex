defmodule FacebookApp.Accounts.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  alias FacebookApp.Accounts.Profile
  alias FacebookApp.Accounts.User

  schema "profiles" do
    field :avatar, :string, null: true
    field :first_name, :string
    field :last_name, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Profile{} = profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :last_name, :avatar])
    |> validate_required([:first_name, :last_name])
    |> assoc_constraint(:user)
  end
end
