defmodule RobotSimulator do
  defstruct direction: :north, position: {0,0}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0,0}) do
    with :ok <- validate_direction(direction),
      :ok <- validate_position(position) do
        %RobotSimulator{direction: direction, position: position}
    end
  end

  defp validate_direction(direction) when direction in [:north,:east,:south,:west], do: :ok
  defp validate_direction(_), do: {:error, "invalid direction"}

  defp validate_position({x,y}) when is_integer(x) and is_integer(y), do: :ok
  defp validate_position(_), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes
    |> Enum.reduce(robot, &move(&1, &2))
  end

  defp move("A", %{direction: direction} = robot) do
    Map.update!(robot, :position, fn {x,y} ->
      case direction do
        :north -> {x, y + 1} 
        :south -> {x, y - 1}
        :east -> {x + 1, y}
        :west -> {x - 1, y}
      end
    end)
  end

  @clockwise [north: :east, east: :south, south: :west, west: :north]
  @anticlockwise [north: :west, east: :north, south: :east, west: :south]
  defp move("R", %{direction: direction} = robot) do
    Map.update!(robot, :direction, fn _ -> 
        Keyword.get(@clockwise, direction)
    end)
  end
  defp move("L", %{direction: direction} = robot) do
    Map.update!(robot, :direction, fn _ -> 
        Keyword.get(@anticlockwise, direction)
    end)
  end
  defp move(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot), do: robot.direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot), do: robot.position
end
