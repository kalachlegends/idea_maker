defmodule IdeaMakerWeb.Router do
  use IdeaMakerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {IdeaMakerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: ["http://localhost:3000"]
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug IdeaMaker.AuthCheck
  end

  scope "/", IdeaMakerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", IdeaMakerWeb do
    pipe_through [:api, :auth]

    get "/", AuthController, :index

    scope "/post" do
      post "/", PostController, :create
      delete "/:id", PostController, :remove
    end

    scope "/groups" do
      get "/", GroupController, :get_by_user_id
      get "/:id", GroupController, :get_by_id
      post "/:id", GroupController, :add_user
      post "/", GroupController, :create
    end

    scope "/users" do
      get "/search/:login", UserController, :search_login
    end

    scope "/auth" do
      get "/me", AuthController, :auth_me
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", IdeaMakerWeb do
    pipe_through [:api]

    scope "/post" do
      get "/", PostController, :get_all
      get "/:id", PostController, :show
      get "/user/:id", PostController, :get_all_by_user_id
    end

    scope "/auth" do
      post "/login", UserController, :login
      post "/register", UserController, :register
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: IdeaMakerWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
