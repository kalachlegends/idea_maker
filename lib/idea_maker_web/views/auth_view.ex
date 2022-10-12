defmodule IdeaMakerWeb.AuthView do
  use IdeaMakerWeb, :view
  import IdeaMakerWeb.ViewHelper

  def render("index.json", data) do
    %{status: "ok", user: data.user}
  end

  def render("error.json", data) do
    error_message(data.message)
  end
end
