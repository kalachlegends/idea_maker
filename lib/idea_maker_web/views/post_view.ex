defmodule IdeaMakerWeb.PostView do
  use IdeaMakerWeb, :view
  import IdeaMakerWeb.ViewHelper

  def render("index.json", data) do
    %{status: "ok", message: data.message}
  end

  def render("error.json", data) do
    error_message(data.message)
  end

  def render("post.json", data) do
    %{status: "ok", post: data.post}
  end
end
