defmodule FacebookApp.Accounts.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  alias FacebookApp.Accounts.Profile
  alias FacebookApp.Accounts.User
  alias FacebookApp.Accounts.Idcon

  schema "profiles" do
    field :avatar, :string
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
    |> avatar_path(attrs)
  end

  defp avatar_path(changeset, attrs) do

    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{first_name: first_name}} ->
        put_change(changeset, :avatar, Idcon.gen_idcon_path(attrs["email"]))
      _ ->
        changeset
    end

  end
end
