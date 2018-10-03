defmodule RobotSimulator do
  defstruct direction: :north, position: {0,0}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0,0})
  def create(direction, _) when direction not in [:north,:east,:south,:west] do
    {:error, "invalid direction"}
  end
  def create(_, position) when not(is_tuple(position) and tuple_size(position) == 2) do
    {:error, "invalid position"}
  end
  def create(_, {x,y}) when not(is_integer(x) and is_integer(y)) do
    {:error, "invalid position"}
  end
  def create(direction, position) do
    %RobotSimulator{direction: direction, position: position}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    case String.match?(instructions, ~r/^[RLA]+$/) do
      false -> {:error, "invalid instruction"}
      true -> String.split(instructions, "", trim: true)
        |> Enum.reduce(robot, fn (instruction, robot) -> 
          case instruction do
            "A" -> move_position(robot)
            direction -> turn_direction(robot, direction) 
          end
        end) 
    end
  end

  defp move_position(robot) do
    %{direction: direction} = robot
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
  defp turn_direction(robot, direction_action) do
    Map.update!(robot, :direction, fn direction -> 
      case direction_action do
        "R" -> Keyword.get(@clockwise, direction)
        "L" -> Keyword.get(@anticlockwise, direction)
      end
    end)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot), do: Map.get(robot, :direction)

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot), do: Map.get(robot, :position)
end
