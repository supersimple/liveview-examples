defmodule LvexamplesWeb.Router do
  use LvexamplesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LvexamplesWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LvexamplesWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/simple", SimpleLive, :index
    live "/events-up", EventsUpLive, :index
    live "/events-up-down", EventsUpDownLive, :index
    live "/events-self", EventsSelfLive, :index
    live "/events-js", EventsJSLive, :index
    live "/complex", ComplexLive, :index
    live "/events-surface", EventsSurfaceLive, :index
  end
end
