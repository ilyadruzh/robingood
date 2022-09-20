defmodule TodoServer do
  @moduledoc """
  Documentation for `Todo`.
  """
  use GenServer

  @impl GenServer
  def init(_) do
    {:ok, TodoList.new()}
  end

  @impl GenServer
  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def handle_info(:cleanup, state) do
    IO.puts("perfoming cleanup...")
    {:noreply, state}
  end

  def add_entry(new_entry) do
    GenServer.cast(__MODULE__, {:add_entry, new_entry})
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, state) do
    {:noreply, TodoList.add_entry(state, new_entry)}
  end

  def update_entry(entry_id, update_func) do
    GenServer.cast(__MODULE__, {:update_entry, entry_id, update_func})
  end

  @impl GenServer
  def handle_cast({:update_entry, entry_id, update_func}, state) do
    {:noreply, TodoList.update_entry(state, entry_id, update_func)}
  end

  def delete_entry(id) do
    GenServer.cast(__MODULE__, {:delete_entry, id})
  end

  @impl GenServer
  def handle_cast({:delete_entry, id}, state) do
    {:noreply, TodoList.delete_entry(state, id)}
  end

  def entries(date) do
    GenServer.call(__MODULE__, {:entries, date})
  end

  @impl GenServer
  def handle_call({:entries, date}, _, state) do
    res = TodoList.entries(state, date)
    {:reply, res, state}
  end
end
