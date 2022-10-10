defmodule IdeaMaker do
  @moduledoc """
  IdeaMaker keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def hash(string), do: :crypto.hash(:md5, string) |> Base.encode16()
end
