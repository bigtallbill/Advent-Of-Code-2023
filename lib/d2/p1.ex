# --- Day 2: Cube Conundrum ---
#
# You're launched high into the atmosphere! The apex of your trajectory just
# barely reaches the surface of a large island floating in the sky. You gently
# land in a fluffy pile of leaves. It's quite cold, but you don't see much snow. An Elf runs over to greet you.
#
# The Elf explains that you've arrived at Snow Island and apologizes for the lack of snow.
# He'll be happy to explain the situation, but it's a bit of a walk, so you have some time.
# They don't get many visitors up here; would you like to play a game in the meantime?
#
# As you walk, the Elf shows you a small bag and some cubes which are either red, green, or blue.
# Each time you play this game, he will hide a secret number of cubes of each color in the bag,
# and your goal is to figure out information about the number of cubes.
#
# To get information, once a bag has been loaded with cubes, the Elf will reach
# into the bag, grab a handful of random cubes, show them to you, and then put them back in the bag.
# He'll do this a few times per game.
#
# You play several games and record the information from each game (your puzzle input).
# Each game is listed with its ID number (like the 11 in Game 11: ...) followed by a
# semicolon-separated list of subsets of cubes that were revealed from the bag (like 3 red, 5 green, 4 blue).
#
# For example, the record of a few games might look like this:
#
#  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
#  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
#  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
#  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
#  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
#
# In game 1, three sets of cubes are revealed from the bag (and then put back again).
# The first set is 3 blue cubes and 4 red cubes; the second set is 1 red cube, 2 green cubes, and 6 blue cubes; the third set is only 2 green cubes.
#
# The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
#
# In the example above, games 1, 2, and 5 would have been possible if the bag had
# been loaded with that configuration. However, game 3 would have been impossible
# because at one point the Elf showed you 20 red cubes at once; similarly, game 4 would also have been
# impossible because the Elf showed you 15 blue cubes at once. If you add up the IDs of the games that would have been possible, you get 8.
#
# Determine which games would have been possible if the bag had been loaded with
# only 12 red cubes, 13 green cubes, and 14 blue cubes. What is the sum of the IDs of those games?

defmodule AOCD2P1 do
  def run do
    stream = File.stream!("assets/d2/data.txt")

    Enum.map(stream, &parse_line(&1))
    |> Enum.sum()
  end

  def run_test_1 do
    stream = File.stream!("assets/d2/test.txt")

    Enum.map(stream, &parse_line(&1))
    |> Enum.sum()
  end

  @doc """
  Parses a line from the game data.

  The line should be in the format "Game game_id: set1; set2; ...", where
  game_id is the ID of the game and each set is a semicolon-separated list of cubes.

  Each set is parsed using the parse_set function.

  After parsing the line, it checks if the game is possible based on the provided sets.
  If the game is possible, it returns the game_id. Otherwise, it returns 0.
  """
  def parse_line(line) when is_bitstring(line) do
    [raw_game, raw_sets] = String.trim(line) |> String.split(":")

    game_id = String.trim(raw_game, "Game ") |> String.to_integer()
    sets = String.split(raw_sets, ";") |> Enum.map(&parse_set/1)

    if is_game_possible?(sets) do
      game_id
    else
      0
    end
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

  @doc """
  Checks if a game is possible based on the provided sets.

  A game is considered possible if all sets meet the following conditions:
  - The number of red items is less than or equal to 12
  - The number of green items is less than or equal to 13
  - The number of blue items is less than or equal to 14
  """
  def is_game_possible?(sets) when is_list(sets) do
    Enum.all?(sets, fn %{red: red, green: green, blue: blue} ->
      red <= 12 && green <= 13 && blue <= 14
    end)
  end
end
