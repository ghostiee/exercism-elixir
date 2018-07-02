defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  import Enum, only: [zip: 2, reduce: 3, reverse: 1, slice: 2]
  import Integer, only: [digits: 2]
  import List, only: [last: 1]

  @messages ["wink","double blink","close your eyes","jump",:reverse]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code = digits(code, 2) |>
    reverse |>
    slice(0..4)

    message = zip(@messages, code) |>
    reduce(
      [],
      fn (({meg, flag}), acc) ->
        if (flag === 1), do: acc ++ [meg], else: acc
      end
    )

    if last(message) === :reverse do
      [:reverse | message] = reverse(message)
    end

    message
  end
end
