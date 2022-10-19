defmodule IdeaMaker.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat" do
    field :messages_one, {:array, :string}
    field :messages_two, {:array, :string}
    field :user_id_one, :id
    field :user_id_two, :id

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:messages_one, :messages_two])
    |> validate_required([:messages_one, :messages_two])
  end
end
