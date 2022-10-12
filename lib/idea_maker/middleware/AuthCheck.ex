defmodule IdeaMaker.AuthCheck do
  import Plug.Conn

  def init(options), do: options

  def get_token(conn) do
    auth = get_req_header(conn, "authorization")

    token =
      hd(auth)
      |> String.replace("Bearer ", "")

    {:ok, token}
  end

  def call(conn, _opts \\ %{}) do
    auth = get_req_header(conn, "authorization")

    if auth != [] do
      token =
        hd(auth)
        |> String.replace("Bearer ", "")

      case IdeaMaker.Token.verify_and_validate(token) do
        {:ok, _claims} ->
          conn

        {:error, _err} ->
          map_message =
            %{status: "error", message: "Auth token not valid"}
            |> Jason.encode!()

          put_resp_content_type(conn, "application/json; charset=utf-8")
          |> send_resp(401, map_message)
      end
    else
      map_message =
        %{status: "error", message: "Auth token not find"}
        |> Jason.encode!()

      put_resp_content_type(conn, "application/json; charset=utf-8")
      |> send_resp(401, map_message)
    end
  end
end
