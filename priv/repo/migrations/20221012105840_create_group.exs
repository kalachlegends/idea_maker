defmodule IdeaMaker.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:group) do
      add :title, :string
      add :user_ids, {:array, :integer}
      add :idea_ids, {:array, :integer}
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:group, [:user_id])
  end
end
