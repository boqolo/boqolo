defmodule RayyanSite.Util do

  Application.ensure_started(:tzdata)
  Application.ensure_loaded(:tzdata)

  def today() do
    {:ok, dt} = DateTime.now("America/Chicago")
    DateTime.to_date(dt)
  end

end
