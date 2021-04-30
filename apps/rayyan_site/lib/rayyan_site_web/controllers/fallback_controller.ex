defmodule RayyanSiteWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, :enoent}) do
    conn
    |> put_status(404)
    |> put_view(RayyanSiteWeb.ErrorView)
    |> render("404.html")
  end

end
