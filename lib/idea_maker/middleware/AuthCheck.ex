defmodule IdeaMaker.AuthCheck do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> get_req_header("Authorization")
    |> IO.inspect(label: "Auth")

    conn
  end
end
