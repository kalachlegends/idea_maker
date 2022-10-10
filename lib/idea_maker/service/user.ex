defmodule IdeaMaker.Service.User do
  import Ecto.Query
  alias IdeaMaker.{Repo, User, Data}

  def login(email, password) do
    password = IdeaMaker.hash(password)

    query =
      from user in User,
        where: user.email == ^email and user.password == ^password

    user = Repo.one(query)

    if !is_nil(user) do
      token = IdeaMaker.Token.generate_and_sign!(%{"user_id" => user.id})
      {:ok, user, token}
    else
      {:error, "login or password not valid"}
    end
  end

  def register(email, password, _data) do
    hash_pass = IdeaMaker.hash(password)

    case Repo.insert(
           User.changeset(%User{}, %{email: email, password: hash_pass, data: Data.user()})
         ) do
      {:ok, struct} ->
        token = IdeaMaker.Token.generate_and_sign!(%{"user_id" => struct.id})

        {:ok, struct, token}

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
