defmodule BinTree do
  import Inspect.Algebra

  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{value: any, left: BinTree.t() | nil, right: BinTree.t() | nil}
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat([
      "(",
      to_doc(v, opts),
      ":",
      if(l, do: to_doc(l, opts), else: ""),
      ":",
      if(r, do: to_doc(r, opts), else: ""),
      ")"
    ])
  end
end

defmodule Zipper do
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t()) :: Z.t()
  def from_tree(bt) do
    {[], bt}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t()) :: BT.t()
  def to_tree({[], bt}) do bt end
  def to_tree(z) do
    up(z)
    |> to_tree
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t()) :: any
  def value({_, %{value: value}}) do
    value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t()) :: Z.t() | nil
  def left({_, %{left: nil}}) do nil end
  def left({thread, %{value: v, left: l, right: r}}) do
    {[{:left, v, r} | thread], l}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t()) :: Z.t() | nil
  def left({_, %{right: nil}}) do nil end
  def right({thread, %{value: v, left: l, right: r}}) do
    {[{:right, v, l} | thread], r}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t()) :: Z.t()
  def up({[], _}) do nil end
  def up({[{:left, v, r} | thread], bt}) do
    {thread, %BinTree{left: bt, value: v, right: r}}
  end
  def up({[{:right, v, l} | thread], bt}) do
    {thread, %BinTree{right: bt, value: v, left: l}}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t(), any) :: Z.t()
  def set_value({thread, %{right: r, left: l}}, v) do
    {thread, %BinTree{right: r, value: v, left: l}}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t(), BT.t()) :: Z.t()
  def set_left({thread, %{right: r, value: v}}, l) do
    {thread, %BinTree{right: r, value: v, left: l}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t(), BT.t()) :: Z.t()
  def set_right({thread, %{value: v, left: l}}, r) do
    {thread, %BinTree{right: r, value: v, left: l}}
  end
end
