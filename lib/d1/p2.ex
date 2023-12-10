defmodule AOCD1P2 do
  def run do
    stream = File.stream!("assets/d1/data.txt")

    Enum.map(stream, &fix_value!(&1))
    |> Enum.sum()
  end

  def fix_value!(line) when is_bitstring(line) do
    String.trim(line)
    # convert to a list of graphemes (characters)
    |> String.graphemes()
    # reduce to only a list of numbers in order (discard non-numbers)
    |> to_ordered_numbers()
    |> combine_first_and_last()
    |> String.to_integer()
  end

  @doc """
  Combines the first and last elements of a list.
  If the list is empty, it raises an error.
  If the list contains only one element, it duplicates that element.
  If the list contains more than one element, it concatenates the first and last elements.
  """
  def combine_first_and_last(list) when is_list(list) do
    case list do
      # If we have no values then something is wrong
      [] -> raise("bah humbug")
      # If we have only 1 value then it is both "first" and "last" so we combine it with itself
      [one_value] -> one_value <> one_value
      # If we have more than 1 value then get and combine only the first and last
      [head | tail] -> head <> (Enum.reverse(tail) |> Enum.at(0))
    end
  end

  @doc """
  Processes a list of strings, attempting to convert each string to an integer.
  Only successful conversions are accumulated, in reverse order.
  The final list is then reversed to maintain the original order.
  """
  def to_ordered_numbers(line) when is_list(line) do
    result =
      Enum.reduce(line, %{charlist: "", numbers: []}, fn char, acc ->
        try do
          # This is my (probably stupid) way of figuring out if the string is a number
          _ = String.to_integer(char)
          # If it is a number then add it to the accumulator
          # prepending is faster than appending so we reverse the list at the end
          %{acc | numbers: [char | acc.numbers]}
        rescue
          ArgumentError ->
            new_charlist = char <> acc.charlist

            case number_word_in_suffix(new_charlist) do
              nil -> %{acc | charlist: new_charlist}
              number -> %{acc | numbers: [number | acc.numbers], charlist: new_charlist}
            end
        end
      end)

    Enum.reverse(result.numbers)
  end

  @doc """
  This function takes a string as input and checks if it ends with a numeric word.
  The input string should be reversed before being passed to this function.
  If the reversed string starts with a numeric word, it returns the corresponding number as a string.
  If it doesn't, it returns nil.
  """
  def number_word_in_suffix(text) when is_binary(text) do
    case text do
      "eno" <> _ -> "1"
      "owt" <> _ -> "2"
      "eerht" <> _ -> "3"
      "ruof" <> _ -> "4"
      "evif" <> _ -> "5"
      "xis" <> _ -> "6"
      "neves" <> _ -> "7"
      "thgie" <> _ -> "8"
      "enin" <> _ -> "9"
      _ -> nil
    end
  end
end
