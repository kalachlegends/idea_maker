defmodule IdeaMaker.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group" do
    field :idea_ids, {:array, :integer}
    field :title, :string
    field :user_ids, {:array, :integer}
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:title, :user_ids, :idea_ids])
    |> validate_required([:title, :user_ids, :idea_ids])
  end
end
