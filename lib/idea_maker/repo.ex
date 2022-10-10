defmodule IdeaMaker.Repo do
  use Ecto.Repo,
    otp_app: :idea_maker,
    adapter: Ecto.Adapters.Postgres
end
