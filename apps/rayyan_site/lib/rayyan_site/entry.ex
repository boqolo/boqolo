defmodule Writings.Entry do

  # This enforces certain keys are provided when creating the struct
  @enforce_keys [:id, :title, :date]

  # Here we are creating a struct, which is a more
  # specific kind of map. It takes its name from the
  # module that defines it. Takes a keyword list as
  # initialization.
  defstruct [
    id: nil,
    title: "",
    byline: nil,
    author: "Rayyan Abdi",
    date: nil,
    tags: [],
    # body: ""
  ]

  def parse_meta!(entry_path) do
    # read file, parse to fields, create struct from keyword attrs
    id = parse_entry_id(entry_path)
    contents = File.read!(entry_path)
    params =
      contents
      |> String.split(~r/--\w+--/, include_captures: true, trim: true)
      |> Enum.map(fn str -> String.trim(str) end)
      |> parse_pairs(Keyword.new())
      |> Keyword.delete(:body)
      |> Keyword.put_new(:id, id)
    struct!(__MODULE__, params)
  end

  defp parse_pairs([raw_attr, raw_content | rest], acc) do
    [_, str_attr, _] = String.split(raw_attr, "--")
    attr = String.to_atom(str_attr)
    content = parse_content(attr, raw_content)
    parse_pairs(rest, Keyword.put_new(acc, attr, content))
  end

  defp parse_pairs(_none_or_dangling_attr, acc) do
    acc
  end

  defp parse_entry_id(filepath) do
    filepath
    |> Path.split()
    |> List.last()
    |> Path.rootname()
  end

  defp parse_content(:date, date_erl_str) do
    date_erl_str
    |> String.split(~r/[\{\},\s]/, trim: true) # ["YYYY", "MM", "DD"]
    |> Enum.map(fn s -> String.to_integer(s) end)
    |> List.to_tuple()
    |> Date.from_erl!()
  end

  defp parse_content(:tags, csv) do
    csv
    |> String.split(~r/,/, trim: true)
    |> Enum.map(fn s -> String.trim(s) end)
  end

  defp parse_content(_attr, content) do
    # Default
    content
  end

  def extract_body(file_content) do
    file_content
    |> String.split(~r/--body--/, trim: true)
    |> List.last
    |> String.trim
  end

  def parse_body(text) do
    # TODO add syntax highlighting
    # reference: https://github.com/elixir-lang/ex_doc/blob/d5cde30f55c7e0cde486ec3878067aee82ccc924/lib/ex_doc/highlighter.ex
    Earmark.as_html!(text)
    |> String.replace(~r/\n\n/, "<br>", global: true)
    |> String.replace(~r/\n/, "", global: true)
  end

end
