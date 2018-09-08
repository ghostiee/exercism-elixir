defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    reduce(l, 0, fn (_, acc) -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse([]) do [] end
  def reverse([s | t]) do
    do_reverse(t, [s])
  end
  @spec do_reverse(list, list) :: list
  defp do_reverse([], acc) do acc end
  defp do_reverse([s | t], acc) do
   do_reverse(t, [s | acc])
  end

  @spec map(list, (any -> any)) :: list
  def map([], _) do [] end
  def map([s | t], f) do
    [f.(s) | map(t, f)] 
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _) do [] end
  def filter([s | t], f) do
    case f.(s) do
      false -> filter(t, f)
      true -> [s | filter(t, f)]
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _) do acc end
  def reduce([s | t], acc, f) do
    reduce(t, f.(s, acc), f)
  end

  @spec append(list, list) :: list
  def append([], b) do b end
  def append([s | t], b) do
    [s | append(t, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat([]) do [] end
  def concat([s | t]) do
    append(s, concat(t))
  end
end
