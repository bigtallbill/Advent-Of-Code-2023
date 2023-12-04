defmodule AocD1P2Test do
  use ExUnit.Case
  doctest AOCD1P2

  test "test 1" do
    assert AOCD1P2.fix_value!("1122") == 12
  end

  test "test 2" do
    assert AOCD1P2.fix_value!("1111") == 11
  end

  test "test 3" do
    assert AOCD1P2.fix_value!("1234") == 14
  end

  test "test 4" do
    assert AOCD1P2.fix_value!("91212129") == 99
  end

  test "words" do
    assert AOCD1P2.fix_value!("one212") == 12
  end

  test "words end" do
    assert AOCD1P2.fix_value!("one212two") == 12
  end

  test "overlapping words" do
    assert AOCD1P2.fix_value!("eightwo") == 82
  end

  test "not be the answer of the first part" do
    assert AOCD1P2.run() != 54159
  end

  test "replace_words_with_numbers" do
    assert AOCD1P2.replace_words_with_numbers("one212two") == "1212"
  end

  test "replace_words_with_numbers overlapping" do
    assert AOCD1P2.replace_words_with_numbers("eightwo") == "82"
  end

  test "replace_words_with_numbers overlapping 2" do
    assert AOCD1P2.replace_words_with_numbers("eightwothree") == "823"
  end

  test "replace_words_with_numbers mixed words" do
    assert AOCD1P2.replace_words_with_numbers("eightwo3four") == "8234"
  end

  test "replace_words_with_numbers mixed random characters" do
    assert AOCD1P2.replace_words_with_numbers("hheightwo3fffourfiveaa") == "82345"
  end

  test "gets the right answer" do
    assert AOCD1P2.run() == 0
  end
end
