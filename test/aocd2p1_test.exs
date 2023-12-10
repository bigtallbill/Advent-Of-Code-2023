defmodule AocD2P1Test do
  use ExUnit.Case
  doctest AOCD2P1

  test "parse_line" do
    assert AOCD2P1.parse_line("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green") == 1
  end

  test "parse_line invalid" do
    assert AOCD2P1.parse_line("Game 1: 18 blue, 4 red; 1 red, 2 green, 6 blue; 2 green") == 0
  end

  test "parse_set" do
    assert AOCD2P1.parse_set("3 blue, 4 red") == %{blue: 3, red: 4, green: 0}
  end

  test "is_game_possible?" do
    assert AOCD2P1.is_game_possible?([
             %{blue: 3, red: 4, green: 0},
             %{blue: 6, green: 2, red: 1},
             %{green: 2, blue: 0, red: 0}
           ]) == true

    assert AOCD2P1.is_game_possible?([
             %{blue: 3, red: 4, green: 0},
             %{blue: 6, green: 2, red: 13},
             %{green: 2, blue: 0, red: 0}
           ]) == false
  end

  test "run test" do
    assert AOCD2P1.run_test() == 8
  end

  test "run" do
    assert AOCD2P1.run() == 2101
  end
end
