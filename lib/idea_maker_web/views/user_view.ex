defmodule IdeaMakerWeb.UserView do
  use IdeaMakerWeb, :view

  def render("login.json", data) do
    %{status: "ok", roll: data.token}
  end

  def render("error.json", data) do
    Enum.map(data.message, fn x ->
      x[_]
    end)

    %{status: "error", message: data}
  end
end
