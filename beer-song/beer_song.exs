defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    one(number) <> "\n" <> two(number)
  end

  defp one(number) do
    case number do
      0 -> "No more bottles of beer on the wall, no more bottles of beer."
      1 -> "#{number} bottle of beer on the wall, #{number} bottle of beer."
      _ -> "#{number} bottles of beer on the wall, #{number} bottles of beer."
    end
  end

  defp two(number) do
    case number do
      0 -> "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
      1 -> "Take it down and pass it around, no more bottles of beer on the wall.\n"
      2 -> "Take one down and pass it around, #{number - 1} bottle of beer on the wall.\n"
      _ -> "Take one down and pass it around, #{number - 1} bottles of beer on the wall.\n"
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\99..0) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
