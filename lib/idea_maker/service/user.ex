defmodule IdeaMaker.Service.User do
  import Ecto.Query
  alias IdeaMaker.{Repo, User, Data}

  def login(login, password \\ "") do
    password = IdeaMaker.hash(password)

    query =
      from user in User,
        where: user.login == ^login and user.password == ^password

    user = Repo.one(query)

    if !is_nil(user) do
      token = IdeaMaker.Token.generate_and_sign!(%{"user_id" => user.id})

      user =
        IdeaMaker.normalize_repo(user)
        |> Map.delete(:password)

      {:ok, user, token}
    else
      {:error, "login or password not valid"}
    end
  end

  def register(email, password, login, _data) do
    case Repo.insert(
           User.changeset(%User{}, %{
             email: email,
             login: login,
             password: password,
             data: Data.user()
           })
         ) do
      {:ok, struct} ->
        token = IdeaMaker.Token.generate_and_sign!(%{"user_id" => struct.id})

        user =
          IdeaMaker.normalize_repo(struct)
          |> Map.delete(:password)

        {:ok, user, token}

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
