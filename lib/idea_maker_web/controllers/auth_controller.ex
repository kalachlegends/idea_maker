defmodule IdeaMakerWeb.AuthController do
  use IdeaMakerWeb, :controller
  alias IdeaMaker.{Repo, User, Db}

  def auth_me(conn, _params) do
    with {:ok, token} <- IdeaMaker.AuthCheck.get_token(conn),
         {:ok, claims} <- IdeaMaker.Token.verify_and_validate(token),
         {:ok, user} <- Db.get(User, claims["user_id"]) do
      conn
      |> render("index.json", user: IdeaMaker.normalize_repo(user))
    else
      {:error, reason} ->
        render(conn, "error.json", message: reason)
    end
  end
end
