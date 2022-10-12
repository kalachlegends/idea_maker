defmodule IdeaMakerWeb.UserView do
  use IdeaMakerWeb, :view
  import IdeaMakerWeb.ViewHelper

  def render("login.json", data) do
    %{status: "ok", token: data.token, user: data.user}
  end

  def render("error.json", data) do
    error_message(data.message)
  end
end
