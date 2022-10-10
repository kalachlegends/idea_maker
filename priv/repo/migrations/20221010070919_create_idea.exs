defmodule IdeaMaker.Repo.Migrations.CreateIdea do
  use Ecto.Migration

  def change do
    create table(:idea) do
      add :title, :string
      add :name, :string
      add :content, :string
      add :data, :map
      add :user_id, references(:user, on_delete: :nothing)
      add :group_id, references(:group, on_delete: :nothing)

      timestamps()
    end

    create index(:idea, [:user_id])
    create index(:idea, [:group_id])
  end
end
