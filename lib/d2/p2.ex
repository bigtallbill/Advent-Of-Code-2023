# --- Part Two ---
#
# The Elf says they've stopped producing snow because they aren't getting any water!
# He isn't sure why the water stopped; however, he can show you how to get to the
# water source to check it out for yourself. It's just up ahead!
#
# As you continue your walk, the Elf poses a second question: in each game you played,
# what is the fewest number of cubes of each color that could have been in the bag to make the game possible?
#
# Again consider the example games from earlier:
#
#  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
#  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
#  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
#  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
#  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
#
#    In game 1, the game could have been played with as few as 4 red, 2 green, and 6 blue cubes.
#    If any color had even one fewer cube, the game would have been impossible.
#    Game 2 could have been played with a minimum of 1 red, 3 green, and 4 blue cubes.
#    Game 3 must have been played with at least 20 red, 13 green, and 6 blue cubes.
#    Game 4 required at least 14 red, 3 green, and 15 blue cubes.
#    Game 5 needed no fewer than 6 red, 3 green, and 2 blue cubes in the bag.
#
# The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together.
# The power of the minimum set of cubes in game 1 is 48. In games 2-5 it was 12, 1560, 630, and 36, respectively.
# Adding up these five powers produces the sum 2286.
#
# For each game, find the minimum set of cubes that must have been present. What is the sum of the power of these sets?

defmodule AOCD2P2 do
  def run do
    stream = File.stream!("assets/d2/data.txt")

    Enum.map(stream, &parse_line(&1))
    |> Enum.sum()
  end

  def run_test do
    stream = File.stream!("assets/d2/test2.txt")

    Enum.map(stream, &parse_line(&1))
    |> Enum.sum()
  end

  @doc """
  Parses a line from the game data.

  The line should be in the format "Game game_id: set1; set2; ...", where
  game_id is the ID of the game and each set is a semicolon-separated list of cubes.

  Each set is parsed using the parse_set function.

  After parsing the line, it calculates the maximum count of each color across all sets.
  It then calculates the power of this maximum set and returns it.
  """
  def parse_line(line) when is_bitstring(line) do
    String.trim(line)
    # Split the line at the colon
    |> String.split(":")
    # Get the last element of the list (the game sets)
    |> List.last()
    # Split the game sets at the semicolon
    |> String.split(";")
    # Parse each set
    |> Enum.map(&parse_set/1)
    # Calculate the largest count of each color across all sets
    |> largest_colors()
    # Calculate the power of the game
    |> calc_game_power()
  end

  @doc """
  Calculates the largest count of each color across all sets.

  The function takes a list of sets, where each set is a map with colors as keys and counts as values.
  It returns a map with colors as keys and the maximum count of each color across all sets as values.
  """
  def largest_colors(sets) do
    Enum.reduce(sets, %{red: 0, green: 0, blue: 0}, fn set, acc ->
      Map.merge(acc, set, fn _key, old_val, new_val -> max(old_val, new_val) end)
    end)
  end

  @doc """
  Calculates the game's power based on the set of cubes.

  The function accepts a set of cubes, each represented as a map with colors as keys and counts as values.
  It discards colors with a zero count and then multiplies the counts of the remaining colors.

  Returns the computed power of the game.
  """
  def calc_game_power(set) do
    set
    |> Map.values()
    |> Enum.filter(&(&1 > 0))
    |> Enum.reduce(1, &Kernel.*/2)
  end

  @doc """
  Parses a set of cubes from a string.

  The string should be in the format "count color, count color, ...", where
  count is the number of cubes and color is the color of the cubes.

  Returns a map with the counts of each color.
  """
  def parse_set(set) when is_binary(set) do
    String.trim(set)
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(%{red: 0, green: 0, blue: 0}, fn part, acc ->
      [count, color] = String.split(part, " ") |> Enum.map(&String.trim/1)

      cur = Map.get(acc, String.to_atom(color), 0)

      Map.put(acc, String.to_atom(color), cur + String.to_integer(count))
    end)
  end
end
