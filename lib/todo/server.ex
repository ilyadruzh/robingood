defmodule Todo.Server do
  @moduledoc """
  Documentation for `Todo`.
  """
  use GenServer, restart: :temporary

  def start_link(name) do
    IO.puts("Start server for #{name}")
    GenServer.start_link(__MODULE__, name, name: via_tuple(name))
  end

  defp via_tuple(name) do
    Todo.ProcessRegistry.via_tuple({__MODULE__, name})
  end

  def add_entry(pid, new_entry) do
    GenServer.cast(pid, {:add_entry, new_entry})
  end

  def update_entry(entry_id, update_func) do
    GenServer.cast(__MODULE__, {:update_entry, entry_id, update_func})
  end

  def delete_entry(pid, id) do
    GenServer.cast(pid, {:delete_entry, id})
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

  @impl GenServer
  def init(name) do
    IO.puts("Starting to-do server for #{name}")
    {:ok, {name, Todo.Database.get(name) || Todo.List.new()}}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, {name, todo_list}) do
    {:reply, Todo.List.entries(todo_list, date), {name, todo_list}}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, {name, todo_list}) do
    new_list = Todo.List.add_entry(todo_list, new_entry)
    Todo.Database.store(name, new_list)
    {:noreply, {name, new_list}}
  end

  @impl GenServer
  def handle_cast({:update_entry, entry_id, update_func}, {name, todo_list}) do
    new_list = Todo.List.update_entry(todo_list, entry_id, update_func)
    Todo.Database.store(name, new_list)
    {:noreply, {name, new_list}}
  end

  @impl GenServer
  def handle_cast({:delete_entry, id}, {name, todo_list}) do
    new_list = Todo.List.delete_entry(todo_list, id)
    Todo.Database.store(name, new_list)
    {:noreply, {name, new_list}}
  end
end
