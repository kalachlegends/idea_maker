defmodule IdeaMakerWeb.ViewHelper do
  def error_message(message) do
    cond do
      is_list(message) ->
        Enum.map(message, fn {_k, v} ->
          {message, _} = v
          message
        end)

      true ->
        message
    end

    %{status: "error", message: message}
  end
end
