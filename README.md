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