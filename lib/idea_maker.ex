defmodule IdeaMaker do
  def hash(string), do: :crypto.hash(:md5, string) |> Base.encode16()

  def normalize_repo(struct),
    do: Map.from_struct(struct) |> Map.delete(:__meta__) |> Map.delete(:password)

  def nomalize_list_by_repo(list), do: list |> Enum.map(fn x -> normalize_repo(x) end)
end
