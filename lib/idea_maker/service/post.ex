defmodule IdeaMaker.Service.Post do
  import Ecto.Query
  alias IdeaMaker.{Repo, User, Data, Db, Post}

  def create(conn, data) do
    with {:ok, user} <- IdeaMaker.Service.User.get_user_by_token(conn),
         {:ok, post} <-
           Post.changeset(%Post{}, Map.merge(data, %{user_id: user.id}))
           |> Repo.insert() do
      {:ok, IdeaMaker.normalize_repo(post)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def delete_by_id(conn, id) do
    {:ok, user} = IdeaMaker.Service.User.get_user_by_token(conn)

    post =
      from(
        post in Post,
        where: post.id == ^id and ^user.id == post.user_id
      )
      |> Repo.one()

    if !is_nil(post), do: {:ok, post |> Repo.delete!()}, else: {:error, "Нельзя удалить пост"}
  end

  def get_post_by_user_id(id) do
    user =
      from(
        user in User,
        where: user.id == ^id
      )
      |> Repo.one()

    if is_nil(user) do
      {:error, "Такого пользователя не существует"}
    else
      list =
        from(
          post in Post,
          where: ^id == post.user_id
        )
        |> Repo.all([])
        |> IdeaMaker.nomalize_list_by_repo()

      {:ok, list}
    end
  end
end
