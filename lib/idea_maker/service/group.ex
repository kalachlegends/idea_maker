defmodule IdeaMaker.Service.Group do
  import Ecto.Query
  alias IdeaMaker.{Repo, User, Data, Group, Service.User, Db}

  def create(conn, data) do
    with {:ok, user} <- IdeaMaker.Service.User.get_user_by_token(conn),
         {:ok, group} <-
           Db.add(Group, %{
             title: data.title,
             user_id: user.id,
             user_ids: data.user_ids,
             idea_ids: data.idea_ids
           }) do
      {:ok, IdeaMaker.normalize_repo(group)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def add_user_group(%{id: id, user_ids: user_ids}) do
    with {:ok, group} <- Db.get(Group, id: id),
         {:ok, group} <- Db.update(group, user_ids: Enum.uniq(user_ids ++ group.user_ids)) do
      {:ok, get_users_by_users_ids(group)}
    end
  end

  def get_users_by_users_ids(group) do
    group
    |> IdeaMaker.normalize_repo()
    |> Map.merge(%{users: IdeaMaker.Service.User.get_all_users_by_list(group.user_ids)})
    |> Map.delete(:user_ids)
  end

  def get_by_user_id(conn) do
    with {:ok, user} <- IdeaMaker.Service.User.get_user_by_token(conn),
         {:ok, groups} <- Db.get_all(Group, user_id: user.id) do
      {:ok, IdeaMaker.nomalize_list_by_repo(groups)}
    end
  end
end
