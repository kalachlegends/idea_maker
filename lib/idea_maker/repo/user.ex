defmodule IdeaMaker.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field(:data, :map)
    field(:email, :string)
    field(:password, :string)
    field(:login, :string)
    field :repassword, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :data, :login, :repassword])
    |> validate_required([:email, :password, :data, :login])
    |> validate_format(:email, ~r/@/, message: "Введите валидный email")
    |> validate_length(:password,
      min: 4,
      max: 32,
      message: "Пароль не может быть меньше 4 и не больше 32"
    )
    |> validate_length(:login,
      min: 4,
      max: 32,
      message: "Логин не может быть меньше 4 и не больше 32"
    )
    |> unique_constraint(:login, name: :user_login_index, message: "Логин должен быть уникальным")
    |> unique_constraint(:email, name: :user_email_index, message: "Емайл должен быть уникальным")
    |> ChangesetHelper.password_check(:password, :repassword)
    |> change(password: IdeaMaker.hash(attrs.password))
  end
end
