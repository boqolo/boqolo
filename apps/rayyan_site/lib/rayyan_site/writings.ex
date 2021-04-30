defmodule Writings do
  alias Writings.Entry

  require Logger

  @base_path "priv/writings"

  defp entry_path(topic, filename) do
    Path.join([@base_path, topic, filename]) <> ".md"
  end

  # reference: https://dashbit.co/blog/welcome-to-our-blog-how-it-was-made

  # Make sure all the apps have been generated and started because
  # we need them at compile time to parse posts
  for app <- [:earmark, :makeup_elixir, :tzdata] do
    Application.ensure_all_started(app)
  end

  entry_paths = Path.wildcard("priv/writings/**/*.md")

  entries =
    for entry_path <- entry_paths, into: [] do
      @external_resource Path.relative_to_cwd(entry_path)
      Entry.parse_meta!(entry_path)
    end

  @entries Enum.sort_by(entries, fn e -> e.date end, {:desc, Date})

  def list_entries() do
    @entries
  end

  def get_entry(id) do
    list_entries()
    |> Enum.find(&(&1.id == id))
  end

  def html_content(filename) do
    html_content(filename, filename)
  end

  def html_content(topic, filename) do
    with {:ok, content} <- File.read(entry_path(topic, filename)),
      body <- Entry.extract_body(content) do
        Logger.debug(body)
      {:ok, Entry.parse_body(body)}
    end
  end

end
