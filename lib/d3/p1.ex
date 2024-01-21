# --- Day 3: Gear Ratios ---
#
# You and the Elf eventually reach a gondola lift station;
# he says the gondola lift will take you up to the water source,
# but this is as far as he can bring you. You go inside.
#
# It doesn't take long to find the gondolas,
# but there seems to be a problem: they're not moving.
#
# "Aaah!"
#
# You turn around to see a slightly-greasy Elf with a wrench and a look of surprise.
# "Sorry, I wasn't expecting anyone! The gondola lift isn't working right now; it'll still be a while before I can fix it." You offer to help.
#
# The engineer explains that an engine part seems to be missing from the engine,
# but nobody can figure out which one. If you can add up all the part numbers
# in the engine schematic, it should be easy to work out which part is missing.
#
# The engine schematic (your puzzle input) consists of a visual representation of the engine.
# There are lots of numbers and symbols you don't really understand,
# but apparently any number adjacent to a symbol, even diagonally,
# is a "part number" and should be included in your sum. (Periods (.) do not count as a symbol.)
#
# Here is an example engine schematic:
#
#  467..114..
#  ...*......
#  ..35..633.
#  ......#...
#  617*......
#  .....+.58.
#  ..592.....
#  ......755.
#  ...$.*....
#  .664.598..
#
# In this schematic, two numbers are not part numbers because they are not adjacent to a symbol: 114 (top right) and 58 (middle right).
# Every other number is adjacent to a symbol and so is a part number; their sum is 4361.
#
# Of course, the actual engine schematic is much larger. What is the sum of all of the part numbers in the engine schematic?

defmodule AOCD3P1 do
  def run do
    stream = File.stream!("assets/d3/data.txt")

    Stream.map(stream, &parse_line(&1))
    |> Enum.sum()
  end

  def run_test do
    stream = File.stream!("assets/d3/test1.txt")

    Stream.map(stream, &parse_line(&1))
    |> Enum.sum()
  end

  def parse_line(line) when is_bitstring(line) do
    line = String.trim(line)

    number_coords =
      Regex.scan(~r/\d+/, line, return: :index)
      |> match_to_numbers(line)

    symbol_coords =
      Regex.scan(~r/[^\d.]/, line, return: :index)
      |> match_to_symbols(line)

    %{number_coords: number_coords, symbol_coords: symbol_coords}
  end

  def match_to_numbers(coords, line) do
    Enum.map(coords, fn [{i, size}] ->
      number = String.slice(line, i, size) |> String.to_integer()
      %{start_idx: i, end_idx: i + size - 1, number: number}
    end)
  end

  def match_to_symbols(symbols, line) do
    Enum.map(symbols, fn [{i, size}] ->
      number = String.slice(line, i, size)
      %{start_idx: i, end_idx: i + size - 1, symbol: number}
    end)
  end

  def numbers_with_adjacent_symbols(%{number_coords: [], symbol_coords: []}), do: []

  def numbers_with_adjacent_symbols(%{number_coords: nums, symbol_coords: []})
      when is_list(nums),
      do: []

  def numbers_with_adjacent_symbols(%{number_coords: [], symbol_coords: symbols})
      when is_list(symbols),
      do: []

  def numbers_with_adjacent_symbols(%{number_coords: nums, symbol_coords: symbols})
      when is_list(nums) and is_list(symbols) do
    Enum.reduce(nums, [], fn num, acc ->
      if Enum.any?(symbols, fn %{start_idx: start_idx, end_idx: end_idx} ->
           num.start_idx - 1 <= end_idx and num.end_idx + 1 >= start_idx
         end) do
        [num | acc]
      else
        acc
      end
    end)
  end

  def numbers_with_adjacent_symbols(%{number_coords: cur_nums, symbol_coords: cur_symbols}, %{
        number_coords: prev_nums,
        symbol_coords: prev_symbols
      }) do
    cur_nums_with_adjacent_symbols =
      numbers_with_adjacent_symbols(%{
        number_coords: cur_nums,
        symbol_coords: cur_symbols
      })

    prev_nums_with_adjacent_symbols =
      numbers_with_adjacent_symbols(%{
        # we want to check the current numbers against the previous symbols
        number_coords: cur_nums,
        symbol_coords: prev_symbols
      })

    cur_nums_with_adjacent_symbols
    |> Enum.concat(prev_nums_with_adjacent_symbols)
    |> Enum.uniq()
  end
end
