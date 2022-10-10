defmodule IdeaMaker.Idea do
  use Ecto.Schema
  import Ecto.Changeset

  schema "idea" do
    field :content, :string
    field :data, :map
    field :name, :string
    field :title, :string
    field :user_id, :id
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(idea, attrs) do
    idea
    |> cast(attrs, [:title, :name, :content, :data])
    |> validate_required([:title, :name, :content, :data])
  end
end
