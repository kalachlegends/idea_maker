defmodule IdeaMaker.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :email, :string
      add :password, :string
      add :data, :map

      timestamps()
    end

    create unique_index(:user, [:email])
  end
end
