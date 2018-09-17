defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{:data => node_data} = tree, data) when data <= node_data do
    Map.update(tree, :left, new(data), &insert(&1, data))
  end
  def insert(tree, data) do
    Map.update(tree, :right, new(data), &insert(&1, data))
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil) do [] end
  def in_order(tree) do
    in_order(Map.get(tree, :left)) 
    ++ [tree.data | in_order(Map.get(tree, :right))] 
  end
end
