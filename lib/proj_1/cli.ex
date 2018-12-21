# lib/proj_1/cli.ex

defmodule Proj1.CLI do
  def main(args) do
    parse_args(args)
    |> process
  end

  def parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean],
                              aliases: [h: :help])
    case parse do
      {[help: true], _, _}
        -> :help
      {_, [search_term], _}
      -> {search_term}
    end
  end

  def process({search_term}) do
    IO.inspect search_term
  end

end
