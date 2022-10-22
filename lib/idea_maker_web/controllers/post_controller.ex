defmodule IdeaMakerWeb.PostController do
  use IdeaMakerWeb, :controller
  alias IdeaMaker.{Db, Post}
  alias IdeaMaker.Service.Post, as: PostService

  def create(conn, params) do
    data = %{
      title: params["title"],
      content: params["content"],
      description: params["description"],
      url_img: params["url_img"]
    }

    case PostService.create(conn, data) do
      {:ok, data} ->
        render(conn, "post.json", post: data)

      {:error, reason} ->
        conn
        |> resp(406, "Err")
        |> render("error.json", message: reason)
    end
  end

  def get_all(conn, _params) do
    case Db.get_all(Post) do
      {:ok, data} ->
        render(conn, "post.json", post: IdeaMaker.nomalize_list_by_repo(data))

      {:error, reason} ->
        conn
        |> resp(404, "Err")
        |> render("error.json", message: "Error")
    end
  end

  def get_all_by_user_id(conn, params) do
    case PostService.get_post_by_user_id(params["id"]) do
      {:ok, data} ->
        render(conn, "post.json", post: data)

      {:error, reason} ->
        conn
        |> resp(404, "Err")
        |> render("error.json", message: reason)
    end
  end

  def show(conn, params) do
    case Db.get(Post, params["id"]) do
      {:ok, data} ->
        render(conn, "post.json", post: IdeaMaker.normalize_repo(data))

      {:error, _reason} ->
        conn
        |> resp(404, "Err")
        |> render("error.json", message: "Не найден пост")
    end
  end

  def remove(conn, params) do
    case PostService.delete_by_id(conn, params["id"]) do
      {:ok, _data} ->
        render(conn, "index.json", message: "Успешно удален")

      {:error, reason} ->
        conn
        |> resp(404, "Err")
        |> render("error.json", message: reason)
    end
  end
end
