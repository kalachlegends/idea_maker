defmodule IdeaMaker.Group_Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_post" do
    field :content, :string
    field :title, :string
    field :url_images, :string
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(group__post, attrs) do
    group__post
    |> cast(attrs, [:title, :content, :url_images])
    |> validate_required([:title, :content, :url_images])
  end
end
