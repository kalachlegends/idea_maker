defmodule IdeaMakerWeb.UserController do
  use IdeaMakerWeb, :controller
  alias IdeaMaker.{Repo, User, Data, Service}

  def register(conn, params) do
    case Service.User.register(params["email"], params["password"], params["data"]) do
      {:ok, struct, token} ->
        render(conn, "login.json", user: struct, token: token)

      {:error, changset} ->
        conn
        |> resp(406, "Err")
        |> render("error.json", message: changset.errors)
    end
  end

  def login(conn, params) do
    case Service.User.login(params["email"], params["password"]) do
      {:ok, struct, token} ->
        render(conn, "login.json", user: struct, token: token)

      {:error, message} ->
        conn
        |> resp(406, "Err")
        |> render("error.json", message: message)
    end

    render(conn, "index.json")
  end
end
