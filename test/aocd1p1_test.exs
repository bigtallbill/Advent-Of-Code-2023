defmodule AocD1P1Test do
  use ExUnit.Case
  doctest AOCD1P1

  test "test 1" do
    assert AOCD1P1.fix_value!("1122") == 12
  end

  test "test 2" do
    assert AOCD1P1.fix_value!("1111") == 11
  end

  test "test 3" do
    assert AOCD1P1.fix_value!("1234") == 14
  end

  test "test 4" do
    assert AOCD1P1.fix_value!("91212129") == 99
  end

  test "gets the right answer" do
    assert AOCD1P1.run() == 54159
  end
end
