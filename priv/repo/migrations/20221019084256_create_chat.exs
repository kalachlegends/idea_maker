defmodule IdeaMaker.Repo.Migrations.CreateChat do
  use Ecto.Migration

  def change do
    create table(:chat) do
      add :messages_one, {:array, :string}
      add :messages_two, {:array, :string}
      add :user_id_one, references(:user, on_delete: :nothing)
      add :user_id_two, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:chat, [:user_id_one])
    create index(:chat, [:user_id_two])
  end
end
