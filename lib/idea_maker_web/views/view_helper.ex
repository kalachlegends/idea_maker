defmodule IdeaMakerWeb.ViewHelper do
  def error_message(message) do
    IO.inspect(message, label: "asddsaadsadsasdasdasd")

    message =
      cond do
        is_list(message) ->
          Enum.map(message, fn {k, v} ->
            {message, _} = v
            %{"#{k}" => message}
          end)

        is_struct(message) ->
          Enum.map(message.errors, fn {k, v} ->
            {message, _} = v
            %{"#{k}" => message}
          end)

        true ->
          message
      end

    %{status: "error", message: message}
  end
end
