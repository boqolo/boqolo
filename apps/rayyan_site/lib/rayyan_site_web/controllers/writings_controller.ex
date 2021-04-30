defmodule RayyanSiteWeb.WritingsController do
  use RayyanSiteWeb, :controller

  require Logger

  action_fallback RayyanSiteWeb.FallbackController

  def topic_index(conn, %{"topic" => topic}) do
    # TODO listing if multiple
    with {:ok, content} <- Writings.html_content(topic) do
      conn
      |> assign(:post, Writings.get_entry(topic))
      |> assign(:content, content)
      |> render("show.html")
    end
  end

  def show(conn, %{"topic" => topic, "file" => file}) do
    Logger.debug(topic, file)
    # |> assign(:key, val)  this attr will now be ready for use in the template
    conn
  end

end
