defmodule AocD3P1Test do
  use ExUnit.Case
  doctest AOCD3P1

  test "parse_line" do
    assert AOCD3P1.parse_line("..35..633.") == "..35..633."
  end

  test "run test" do
    assert AOCD3P1.run_test() == 4361
  end

  test "run" do
    assert AOCD3P1.run() == 0
  end
end
