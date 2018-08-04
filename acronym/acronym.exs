defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.replace(~r/(\p{Ll})(\p{Lu})/, string, "\\1 \\2")
    |> String.split(~r{[ -]})
    |> Enum.map(fn w ->
      String.first(w)
      |> String.upcase
     end)
    |> Enum.join
  end
end
