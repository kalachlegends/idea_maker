defmodule IdeaMakerWeb.AuthView do
  use IdeaMakerWeb, :view

  def render("index.json", data) do
    IO.inspect(data.token)
    %{status: "ok", roll: data.token}
  end
end
