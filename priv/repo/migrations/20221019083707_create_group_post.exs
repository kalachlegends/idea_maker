defmodule IdeaMaker.Repo.Migrations.CreateGroupPost do
  use Ecto.Migration

  def change do
    create table(:group_post) do
      add :title, :string
      add :content, :string
      add :description, :string
      add :url_img, :string
      add :group_id, references(:group, on_delete: :nothing)

      timestamps()
    end

    create index(:group_post, [:group_id])
  end
end
