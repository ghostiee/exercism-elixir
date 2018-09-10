defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    String.split(m, "\n")
    |> Enum.map_join(fn t -> process(t) end)
    |> strong
    |> emphasize
    |> wrap_list
  end

  defp process("#" <> t), do: parse_header_level(t, 1)
  defp process("* " <> t), do: "<li>#{t}</li>"
  defp process(t), do: "<p>#{t}</p>"

  defp parse_header_level(" " <> hwt, level) do
    "<h#{level}>#{hwt}</h#{level}>"
  end
  defp parse_header_level("#" <> hwt, level) do
    parse_header_level(hwt, level + 1)
  end

  defp strong(t) do
    String.replace(t, ~r/__([^_]+)__/, "<strong>\\1</strong>")
  end

  defp emphasize(t) do
    String.replace(t, ~r/_([^_]+)_/, "<em>\\1</em>")
  end

  defp wrap_list(l) do
    String.replace(l, "<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
