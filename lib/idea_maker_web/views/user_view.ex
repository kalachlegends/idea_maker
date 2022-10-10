defmodule IdeaMakerWeb.UserView do
  use IdeaMakerWeb, :view

  def render("login.json", data) do
    %{status: "ok", roll: data.token}
  end

  def render("error.json", data) do
    data =
      Enum.map(data.message, fn {k, v} ->
        {message, _} = v
        message
      end)

    IO.inspect(data)
    %{status: "error", message: data}
  end
end
