defmodule IdeaMakerWeb.UserSocket do
  use Phoenix.Socket

  channel "rooms:*", IdeaMakerWeb.RoomChannel

  transport(:websocket, Phoenix.Transports.WebSocket)
  transport(:longpoll, Phoenix.Transports.LongPoll)

  def connect(params, socket, _connect_info) do
    {:ok, assign(socket, :user_id, params["user_id"])}
  end

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
