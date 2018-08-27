defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      is_sublist?(a, b) -> :sublist
      is_sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp is_sublist?([], _) do
    true
  end

  defp is_sublist?(_, []) do
    false
  end

  defp is_sublist?(a, b) when length(a) > length(b) do
    false
  end

  defp is_sublist?(a, b) do
    Stream.chunk(b, length(a), 1)
    |> Enum.any?(&(&1 === a))
  end
end
