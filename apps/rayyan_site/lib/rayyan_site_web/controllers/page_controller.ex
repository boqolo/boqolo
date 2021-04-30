defmodule RayyanSiteWeb.PageController do
  use RayyanSiteWeb, :controller

  # NOTE remember that the view corresponding with this controller name
  # is what is being used by default when rendering templates here.
  # To use another view/template, put the view on the conn first

  action_fallback RayyanSiteWeb.FallbackController

  def index(conn, _) do
    conn
    |> render("home.html")
  end

  def writings(conn, _) do
    conn
    |> render("writings.html")
  end

  def not_found(conn, _) do
    conn
    |> put_status(404)
    |> put_view(RayyanSiteWeb.ErrorView)
    |> render("404.html")
  end

end
