defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    cond do
      number >= 1000 -> thousand(number)
      number >= 100 -> hundred(number)
      number >= 10 -> ten(number)
      true -> digit(number)
    end
  end

  defp thousand(number) do
    convert(div(number, 1000), "M") <> hundred(rem(number, 1000))
  end

  defp hundred(number) do
    convert(div(number, 100), "C", "D", "M") <> ten(rem(number, 100))
  end

  defp ten(number) do
    convert(div(number, 10), "X", "L", "C") <> digit(rem(number, 10))
  end

  defp digit(number) do
    convert(number, "I", "V", "X")
  end

  defp convert(number, one) do
    String.duplicate(one, number)
  end

  defp convert(number, one, five, ten) do
    cond do
      number <= 3 -> convert(number, one)
      number === 4 -> one <> five
      number === 5 -> five
      number < 9 -> five <> convert(number - 5, one)
      number === 9 -> one <> ten
    end
  end
end
