defmodule IdeaMakerWeb.GroupController do
  use IdeaMakerWeb, :controller
  alias IdeaMaker.{Repo, User, Data, Service, Db, Group}

  def create(conn, params) do
    case IdeaMaker.Service.Group.create(
           conn,
           %{
             title: params["title"],
             user_ids: params["user_ids"],
             idea_ids: params["idea_ids"]
           }
         ) do
      {:ok, group} ->
        render(conn, "index.json", message: group)

      {:error, reason} ->
        render(conn, "error.json", message: reason)
    end
  end

  def get_by_user_id(conn, _params) do
    case IdeaMaker.Service.Group.get_by_user_id(conn) do
      {:ok, group} -> render(conn, "group.json", group: group)
      {:error, reason} -> render(conn, "error.json", message: reason)
    end
  end

  def add_user(conn, params) do
    data = %{id: params["id"], user_ids: params["user_ids"]}

    case IdeaMaker.Service.Group.add_user_group(data) do
      {:ok, group} -> render(conn, "group.json", group: group)
      {:error, reason} -> render(conn, "error.json", message: reason)
    end
  end

  def get_by_id(conn, params) do
    case Db.get(Group, params["id"]) do
      {:ok, group} ->
        render(conn, "group.json", group: IdeaMaker.Service.Group.get_users_by_users_ids(group))

      {:error, reason} ->
        render(conn, "error.json", message: reason)
    end
  end
end
