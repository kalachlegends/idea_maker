defmodule IdeaMaker.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post" do
    field :content, :string
    field :title, :string
    field :type, :integer
    field :url_images, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :type, :url_images])
    |> validate_required([:title, :content, :type, :url_images])
  end
end
