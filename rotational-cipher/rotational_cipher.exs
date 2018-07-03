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
      x when (x <= 90 and x >= 65) -> 65 + mod(x + shift - 65, 26)
      x when (x <= 122 and x >= 97) -> 97 + mod(x + shift - 97, 26)
      x -> x
    end)
    |> to_string
  end
end
