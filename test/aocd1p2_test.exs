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

  test "to_ordered_numbers with numbers only" do
    assert AOCD1P2.to_ordered_numbers(String.graphemes("1212")) == ["1", "2", "1", "2"]
  end

  test "to_ordered_numbers with overlapping numbers" do
    assert AOCD1P2.to_ordered_numbers(String.graphemes("eightwo")) == ["8", "2"]
  end

  test "to_ordered_numbers with overlapping numbers and words" do
    assert AOCD1P2.to_ordered_numbers(String.graphemes("eightwo3")) == ["8", "2", "3"]
  end

  test "to_ordered_numbers with mixed numbers and words" do
    assert AOCD1P2.to_ordered_numbers(String.graphemes("8two3four")) == ["8", "2", "3", "4"]
  end

  test "to_ordered_numbers with mixed numbers, words and random characters" do
    assert AOCD1P2.to_ordered_numbers(String.graphemes("height23ffourf5aa")) == [
             "8",
             "2",
             "3",
             "4",
             "5"
           ]
  end

  test "number_word_in_suffix with 'one' at the end" do
    assert AOCD1P2.number_word_in_suffix("eno") == "1"
  end

  test "number_word_in_suffix with 'two' at the end" do
    assert AOCD1P2.number_word_in_suffix("owt") == "2"
  end

  test "number_word_in_suffix with 'three' at the end" do
    assert AOCD1P2.number_word_in_suffix("eerht") == "3"
  end

  test "number_word_in_suffix with no number word at the end" do
    assert AOCD1P2.number_word_in_suffix("hello") == nil
  end

  test "gets the right answer" do
    assert AOCD1P2.run() == 53866
  end
end
