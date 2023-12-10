defmodule AocD2P2Test do
  use ExUnit.Case
  doctest AOCD2P2

  test "parse_line" do
    assert AOCD2P2.parse_line("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green") == 48
  end

  test "parse_set" do
    assert AOCD2P2.parse_set("3 blue, 4 red") == %{blue: 3, red: 4, green: 0}
  end

  test "largest_colors" do
    assert AOCD2P2.largest_colors([
             %{blue: 3, red: 4, green: 0},
             %{blue: 6, green: 2, red: 1},
             %{green: 2, blue: 0, red: 0}
           ]) == %{blue: 6, red: 4, green: 2}
  end

  test "calc_game_power" do
    assert AOCD2P2.calc_game_power(%{blue: 3, red: 4, green: 0}) == 12
  end

  test "run test" do
    assert AOCD2P2.run_test() == 2286
  end

  test "run" do
    assert AOCD2P2.run() == 58269
  end
end
