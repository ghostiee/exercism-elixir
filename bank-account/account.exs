defmodule BankAccount do
  use Agent

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = Agent.start_link(fn -> {:ok, 0} end)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.update(account, fn {_, balance} -> {:close, balance} end)
  end

  defp validate_account(account) do
    Agent.get(account, fn 
      {:ok, _} -> :ok 
      {:close, _} -> {:error, :account_closed}
    end)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    with :ok <- validate_account(account) do
      Agent.get(account, fn {:ok, balance} -> balance end)
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    with :ok <- validate_account(account) do
      Agent.get_and_update(account, fn 
        {:ok, balance} -> {{:ok, balance}, {:ok, balance + amount}}
      end)
    end
  end
end
