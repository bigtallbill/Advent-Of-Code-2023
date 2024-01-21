defmodule AocD3P1Test do
  use ExUnit.Case
  doctest AOCD3P1

  test "parse_line" do
    assert AOCD3P1.parse_line("..35..633.") == %{
             number_coords: [
               %{start_idx: 2, end_idx: 3, number: 35},
               %{start_idx: 6, end_idx: 8, number: 633}
             ],
             symbol_coords: []
           }
  end

  test "parse_line with symbols" do
    assert AOCD3P1.parse_line("...$.*....") == %{
             number_coords: [],
             symbol_coords: [
               %{start_idx: 3, end_idx: 3, symbol: "$"},
               %{start_idx: 5, end_idx: 5, symbol: "*"}
             ]
           }
  end

  test "match_to_numbers matches" do
    assert AOCD3P1.match_to_numbers(
             [[{3, 3}]],
             "...999..."
           ) == [
             %{
               start_idx: 3,
               end_idx: 5,
               number: 999
             }
           ]
  end

  test "match_to_symbols matches" do
    assert AOCD3P1.match_to_symbols(
             [[{3, 1}]],
             "...%..."
           ) == [
             %{
               start_idx: 3,
               end_idx: 3,
               symbol: "%"
             }
           ]
  end

  test "numbers_with_adjacent_symbols single line case" do
    assert AOCD3P1.numbers_with_adjacent_symbols(%{
             number_coords: [%{start_idx: 0, end_idx: 2}, %{start_idx: 5, end_idx: 7}],
             symbol_coords: [%{start_idx: 3, end_idx: 3}, %{start_idx: 8, end_idx: 8}]
           }) == [%{start_idx: 5, end_idx: 7}, %{start_idx: 0, end_idx: 2}]
  end

  test "numbers_with_adjacent_symbols single line case one symbol alignment" do
    assert AOCD3P1.numbers_with_adjacent_symbols(%{
             number_coords: [%{start_idx: 0, end_idx: 2}, %{start_idx: 5, end_idx: 7}],
             symbol_coords: [%{start_idx: 3, end_idx: 3}]
           }) == [%{start_idx: 0, end_idx: 2}]
  end

  test "numbers_with_adjacent_symbols single line case zero symbol alignment" do
    assert AOCD3P1.numbers_with_adjacent_symbols(%{
             number_coords: [%{start_idx: 0, end_idx: 2}, %{start_idx: 5, end_idx: 7}],
             symbol_coords: [%{start_idx: 9, end_idx: 9}, %{start_idx: 33, end_idx: 33}]
           }) == []
  end

  test "run test" do
    assert AOCD3P1.run_test() == 4361
  end

  test "run" do
    assert AOCD3P1.run() == 0
  end
end
