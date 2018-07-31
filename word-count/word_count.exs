defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.split(~r{[^[:alnum:]-]}u, sentence, trim: true)
    |> Enum.reduce(%{}, fn (x, acc) ->
      Map.update(acc, String.downcase(x), 1, &(&1 + 1)) 
    end)
  end
end
