defmodule IdeaMakerWeb.UserController do
  use IdeaMakerWeb, :controller
  alias IdeaMaker.{Repo, User, Data, Service, Db}

  def register(conn, params) do
    case Service.User.register(
           params["email"],
           params["password"],
           params["repassword"],
           params["login"],
           params["data"]
         ) do
      {:ok, struct, token} ->
        render(conn, "login.json", user: struct, token: token)

      {:error, changset} ->
        conn
        |> resp(406, "Err")
        |> render("error.json", message: changset.errors)
    end
  end

  def login(conn, params) do
    case Service.User.login(params["login"], params["password"]) do
      {:ok, struct, token} ->
        render(conn, "login.json", user: struct, token: token)

      {:error, message} ->
        conn
        |> resp(406, "Err")
        |> render("error.json", message: message)
    end
  end

  def search_login(conn, params) do
    list = Service.User.search_by_login(params["login"])

    render(conn, "users.json", users: list)
  end
end
