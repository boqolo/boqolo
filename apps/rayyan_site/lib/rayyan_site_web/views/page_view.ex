defmodule RayyanSiteWeb.PageView do
  use RayyanSiteWeb, :view

  def recent_posts() do
    Writings.list_entries
    |> Enum.take(7)
  end

  def all_posts() do
    Writings.list_entries
  end

end
