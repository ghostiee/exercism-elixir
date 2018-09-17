defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _) do :not_found end
  def search(numbers, key) do
    do_search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp do_search(_, _, min, max) when min > max do :not_found end
  defp do_search(numbers, key, min, max) do
    middle = div(min + max, 2)
    middle_value = elem(numbers, middle)
    cond do
      middle_value == key -> {:ok, middle}
      middle_value < key -> do_search(numbers, key, middle + 1, max)
      middle_value > key -> do_search(numbers, key, min, middle - 1)
    end
  end
end
