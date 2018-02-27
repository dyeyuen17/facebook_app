defmodule FacebookApp.Repo.Migrations.CreateReactions do
  use Ecto.Migration

  def change do
    create table(:reactions) do
      add :reaction, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:reactions, [:user_id])
    create index(:reactions, [:post_id])
  end
end
