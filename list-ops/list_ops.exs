defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    List.foldl(l, 0, fn (_, acc) -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse([]) do
    []
  end

  @spec reverse(list) :: list
  def reverse([s | t]) do
    reverse(t, [s])
  end

  @spec reverse(list, list) :: list
  def reverse([s | t], acc) do
   reverse(t, [s | acc]) 
  end

  @spec reverse(list, list) :: list
  def reverse([], acc) do
    acc
  end

  @spec map(list, (any -> any)) :: list
  def map([], _) do
    []
  end

  @spec map(list, (any -> any)) :: list
  def map([s | t], f) do
    [f.(s) | map(t, f)] 
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _) do
    []
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([s | t], f) do
    case f.(s) do
      false -> filter(t, f)
      true -> [s | filter(t, f)]
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([s | t], acc, f) do
    reduce(t, f.(s, acc), f)
  end
  
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _) do
    acc
  end

  @spec append(list, list) :: list
  def append([], b) do
    b
  end
  
  @spec append(list, list) :: list
  def append([s | t], b) do
    [s | append(t, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat([]) do
    []
  end

  @spec concat([[any]]) :: [any]
  def concat([s | t]) do
    append(s, concat(t))
  end
end
