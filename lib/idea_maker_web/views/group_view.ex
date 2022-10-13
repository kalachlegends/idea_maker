defmodule IdeaMakerWeb.GroupView do
  use IdeaMakerWeb, :view
  import IdeaMakerWeb.ViewHelper

  def render("index.json", data) do
    %{status: "ok", message: data.message}
  end

  def render("error.json", data) do
    %{status: "error", message: data.message}
  end

  def render("group.json", data) do
    %{status: "ok", group: data.group}
  end
end
