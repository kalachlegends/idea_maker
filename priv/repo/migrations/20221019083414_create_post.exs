defmodule IdeaMaker.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :title, :string
      add :content, :string
      add :description, :string
      add :url_img, :string
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:post, [:user_id])
  end
end
