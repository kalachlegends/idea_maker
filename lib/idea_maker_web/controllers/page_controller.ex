defmodule IdeaMakerWeb.PageController do
  use IdeaMakerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
