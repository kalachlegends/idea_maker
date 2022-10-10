defmodule IdeaMaker.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :data, :map
    field :email, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :data])
    |> validate_required([:email, :password, :data])
    |> unique_constraint(:email, name: :user_email_index, message: "Должен быть уникальным")
  end
end
