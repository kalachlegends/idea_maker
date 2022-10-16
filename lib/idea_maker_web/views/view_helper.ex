defmodule IdeaMakerWeb.ViewHelper do
  def error_message(message) do
    message =
      cond do
        is_list(message) ->
          Enum.map(message, fn {k, v} ->
            {message, _} = v
            %{"#{k}" => message}
          end)

        true ->
          message
      end

    %{status: "error", message: message}
  end
end
