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
    |> validate_format(:email, ~r/@/, message: "Введите валидный email")
    |> validate_length(:password, min: 4, max: 32, message: "Пароль не может быть меньше 4")
    |> change(password: IdeaMaker.hash(attrs.password))
    |> unique_constraint(:email, name: :user_email_index, message: "Должен быть уникальным")
  end
end
