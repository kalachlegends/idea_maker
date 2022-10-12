defmodule IdeaMaker do
  def hash(string), do: :crypto.hash(:md5, string) |> Base.encode16()

  def normalize_repo(struct),
    do: Map.from_struct(struct) |> Map.delete(:__meta__) |> Map.delete(:password)
end
