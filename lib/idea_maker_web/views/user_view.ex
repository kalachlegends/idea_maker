defmodule IdeaMakerWeb.UserView do
  use IdeaMakerWeb, :view

  def render("login.json", data) do
    %{status: "ok", token: data.token, user: data.user}
  end

  def render("error.json", data) do
    data =
      cond do
        is_list(data.message) ->
          Enum.map(data.message, fn {_k, v} ->
            {message, _} = v
            message
          end)

        true ->
          data.message
      end

    %{status: "error", message: data}
  end
end
