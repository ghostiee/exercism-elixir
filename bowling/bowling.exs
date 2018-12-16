defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    []
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()
  def roll(game, 10) do [:x | game] end
  def roll([], roll) do [{roll}] end
  def roll([{pre_roll} | pre_frame], roll) do
    cond do
      pre_roll + roll == 10 -> [{pre_roll, :/} | pre_frame]
      true -> [{pre_roll, roll} | pre_frame]
    end  
  end
  def roll(pre_frame, roll) do [{roll} | pre_frame] end
     
  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()
  def score(game) do
    game
    |> Enum.reverse
    |> do_score(0) 
  end

  defp do_score([], _) do 0 end
  defp do_score(_, count) when count >= 10 do 0 end
  defp do_score([frame | rest_frame], count) do
    frame_score([frame | rest_frame]) +
      do_score(rest_frame, count + 1)
  end

  defp frame_score([]) do 0 end
  defp frame_score([:x | rest_frame]) do
    case rest_frame do
      [:x, :x | _] -> 30
      [:x, {first, _} | _] -> 20 + first 
      [frame | _] -> 10 + frame_score([frame]) 
    end
  end 
  defp frame_score([{_, :/} | rest_frame]) do
    case rest_frame do
      [] -> 10
      [{first}] -> 10 + first
      [{first, _} | _] -> 10 + first
    end
  end
  defp frame_score([{first, second} | _]) do
    first + second 
  end
end
