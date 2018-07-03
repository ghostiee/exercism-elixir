defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  import Enum, only: [map: 2]
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    to_charlist(text)
    |> map(fn
      x when (x in ?A..?Z) -> ?A + rem(x + shift - ?A, 26)
      x when (x in ?a..?z) -> ?a + rem(x + shift - ?a, 26)
      x -> x
    end)
    |> to_string
  end
end
