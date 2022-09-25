# Robin Good 

```beam.assembly
mix deps.get
mix escript.build
```

```elixir
pid = TodoServer.start()
TodoServer.add_entry(%{date: ~D[2018-12-19], title: "Dentist"})
TodoServer.add_entry(%{date: ~D[2018-12-20], title: "Shoping"})
TodoServer.add_entry(%{date: ~D[2018-12-19], title: "Moving"})
TodoServer.entries(~D[2018-12-19])
TodoServer.update_entry(2, &Map.put(&1, :date, ~D[2018-12-21]))
TodoServer.entries(~D[2018-12-19])
TodoServer.delete_entry(3)
TodoServer.entries(~D[2018-12-19])
TodoServer.entries(~D[2018-12-21]) #1
```

## Cache

```elixir
{:ok, cache} = Todo.Cache.start()
Todo.Cache.server_process(cache, "Bob list")
Todo.Cache.server_process(cache, "Alice list")

{:ok, cache} = Todo.Cache.start()
bob_list = Todo.Cache.server_process(cache, "Bob list")
Todo.Server.add_entry(bob_list, %{date: ~D[2018-12-19], title: "dentist"})
Todo.Server.entries(bob_list, ~D[2018-12-19])
```

```elixir
{:ok, cache} = Todo.Cache.start()
Enum.each(1..100_000, fn index -> Todo.Cache.server_process(cache, "todo list #{index}") end)
```

```elixir
pid = TodoServer.start()
TodoServer.add_entry(%{date: ~D[2018-12-19], title: "Dentist"})
TodoServer.add_entry(%{date: ~D[2018-12-20], title: "Shoping"})
TodoServer.add_entry(%{date: ~D[2018-12-19], title: "Moving"})
TodoServer.entries(~D[2018-12-19])
TodoServer.update_entry(2, &Map.put(&1, :date, ~D[2018-12-21]))
TodoServer.entries(~D[2018-12-19])
TodoServer.delete_entry(3)
TodoServer.entries(~D[2018-12-19])
TodoServer.entries(~D[2018-12-21]) #1
```

```elixir
Supervisor.start_link([Todo.Cache], strategy: :one_for_one)
bob_list = Todo.Cache.server_process("Bob list")
cache_pid = Process.whereis(Todo.Cache)
Process.exit(cache_pid, :kill)
```

```elixir
Todo.System.start_link()
Todo.Cache.server_process("bob list")
:erlang.system_info(:process_count)
Process.exit(Process.whereis(Todo.Cache), :kill)

bob_list = Todo.Cache.server_process("bob list")
:erlang.system_info(:process_count)

Process.exit(Process.whereis(Todo.Database), :kill)
```

## Проверка работа Registry

```elixir
Todo.System.start_link()
Registry.lookup(:todo_registry, {:database_worker, 1})
cache_pid = Process.whereis(Todo.Database)
Process.exit(cache_pid, :kill)
Registry.lookup(:todo_registry, {:database_worker, 1})
```

```sh
curl -d "" "http://localhost:5454/add_entry?list=bob&date=2018-12-19&title=dentist"

curl "http://localhost:5454/entries?list=bob&date=2018-12-19"

```

## Предупреждения

- Function init/1 has no local returnElixirLS Dialyzer
