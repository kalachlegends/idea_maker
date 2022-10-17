defmodule IdeaMaker.Service.User do
  import Ecto.Query
  alias IdeaMaker.{Repo, User, Data, Db}

  def login(login, password \\ "") do
    password = IdeaMaker.hash(password)

    query =
      from user in User,
        where: user.login == ^login and user.password == ^password

    user = Repo.one(query)

    if !is_nil(user) do
      token = IdeaMaker.Token.generate_and_sign!(%{"user_id" => user.id})

      user = IdeaMaker.normalize_repo(user)

      {:ok, user, token}
    else
      {:error, "login or password not valid"}
    end
  end

  def register(email, password, repassword, login, _data) do
    case Repo.insert(
           User.changeset(%User{}, %{
             email: email,
             password: password,
             repassword: repassword,
             login: login,
             data: Data.user()
           })
         ) do
      {:ok, struct} ->
        token = IdeaMaker.Token.generate_and_sign!(%{"user_id" => struct.id})

        user = IdeaMaker.normalize_repo(struct)

        {:ok, user, token}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def get_user_by_token(conn) do
    with {:ok, token} <- IdeaMaker.AuthCheck.get_token(conn),
         {:ok, claims} <- IdeaMaker.Token.verify_and_validate(token),
         {:ok, user} <- Db.get(User, claims["user_id"]) do
      {:ok, user}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  def search_by_login(login) do
    login = "#{login}%"

    from(
      user in User,
      where: like(user.login, ^login)
    )
    |> Repo.all([])
    |> IdeaMaker.nomalize_list_by_repo()
  end

  def get_all_users_by_list(list) do
    from(
      user in User,
      where: user.id in ^list
    )
    |> Repo.all([])
    |> IdeaMaker.nomalize_list_by_repo()
  end
end
