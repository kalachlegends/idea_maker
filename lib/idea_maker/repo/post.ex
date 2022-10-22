defmodule IdeaMaker.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post" do
    field :content, :string
    field :title, :string
    field :description, :string
    field :url_img, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :url_img, :description, :user_id])
    |> validate_required([:title, :content, :description, :user_id])
    |> validate_length(:title,
      min: 4,
      max: 32,
      message: "Не название может быть меньше 4 и не больше 32"
    )
    |> validate_length(:description,
      min: 4,
      max: 52,
      message: "Не название может быть меньше 4 и не больше 52"
    )
    |> EctoCommons.URLValidator.validate_url(:url_img, message: "Должно быть ссылкой на картинку")
  end
end
