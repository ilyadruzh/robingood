defmodule TodoList.CsvImporter do
  def import(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.map(&String.split(&1, ","))
    |> Enum.map(fn line -> {String.split(List.first(line), "/"), List.last(line)} end)
    |> Enum.map(fn line ->
      {Enum.map(elem(line, 0), fn x -> String.to_integer(x) end), elem(line, 1)}
    end)
    |> Enum.map(fn line -> %{date: List.to_tuple(elem(line, 0)), title: elem(line, 1)} end)
    |> TodoList.new()
    |> IO.inspect()
  end
end
