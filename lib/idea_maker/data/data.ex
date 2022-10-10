defmodule IdeaMaker.Data do
  def user(name \\ nil, img \\ nil) do
    %{name: name, img: img}
  end
end
