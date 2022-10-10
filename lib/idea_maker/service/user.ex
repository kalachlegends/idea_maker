defmodule IdeaMaker.Service.User do
  import Ecto.Query
  alias IdeaMaker.{Repo, User, Data}

  def login do
  end

  def register(email, password, _data) do
    hash_pass = IdeaMaker.hash(password)
    signer = Joken.Signer.create("HS256", "secret")

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
