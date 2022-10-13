defmodule IdeaMakerWeb.GroupController do
  use IdeaMakerWeb, :controller
  alias IdeaMaker.{Repo, User, Data, Service}

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

  def get_by_user_id(conn, params) do
    case IdeaMaker.Service.Group.get_by_user_id(conn) do
      {:ok, group} -> render(conn, "group.json", group: group)
      {:error, reason} -> render(conn, "error.json", message: reason)
    end
  end
end
