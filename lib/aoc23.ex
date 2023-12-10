defmodule AOC23 do
  @moduledoc """
  Documentation for `Aoc23`.
  """
  def run_all do
    IO.puts("Day 1 Part 1: " <> to_string(AOCD1P1.run()))
    IO.puts("Day 1 Part 2: " <> to_string(AOCD1P2.run()))

    IO.puts("Day 2 Part 1: " <> to_string(AOCD2P1.run()))
    IO.puts("Day 2 Part 2: " <> to_string(AOCD2P2.run()))
  end
end
