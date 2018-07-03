defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  import Enum, only: [map: 2]
  import Integer, only: [mod: 2]
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    to_charlist(text)
    |> map(fn
      x when (x <= ?Z and x >= ?A) -> ?A + mod(x + shift - ?A, 26)
      x when (x <= ?z and x >= ?a) -> ?a + mod(x + shift - ?a, 26)
      x -> x
    end)
    |> to_string
  end
end
