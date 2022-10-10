defmodule IdeaMakerWeb.AuthController do
  use IdeaMakerWeb, :controller

  def index(conn, _params) do
    signer = Joken.Signer.create("HS256", "secret")

    {:ok, token, claims} = IdeaMaker.Token.generate_and_sign(%{}, signer)

    extra_claims = %{"user_id" => "some_id"}

    token_with_default_plus_custom_claims =
      IdeaMaker.Token.generate_and_sign!(extra_claims, signer)

     #{:ok, claims} = IdeaMaker.Token.verify_and_validate(token, signer)

    conn
    |> render("index.json", token: token_with_default_plus_custom_claims)
  end

  def auth_me(conn, _params) do
    {:ok, body, _conn} = read_body(conn)
    signer = Joken.Signer.create("HS256", "secret")
    body = Jason.decode!(body)
    {:ok, claims} = IdeaMaker.Token.verify_and_validate(body["token"], signer)

    IO.inspect(claims)

    conn
    |> render("index.json", token: claims)
  end
end
