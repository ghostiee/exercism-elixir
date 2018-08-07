defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    [3, 5, 7]
    |> Enum.map(&check_prime_factor(number, &1))
    |> Enum.join
    |> (&(case &1 === "" do
          true -> "#{number}"
          false -> &1
        end)).()
  end

  @prime_factor_map %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }
  defp check_prime_factor(number, factor) do
    case Integer.mod(number, factor) do
      0 -> @prime_factor_map[factor]
      _ -> ""
    end
  end
end
