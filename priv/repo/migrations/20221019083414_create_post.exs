defmodule IdeaMaker.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :title, :string
      add :content, :string
      add :type, :integer
      add :url_images, :string
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:post, [:user_id])
  end
end
