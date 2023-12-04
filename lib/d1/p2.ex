defmodule AOCD1P2 do
  require IEx

  def run do
    stream = File.stream!("assets/d1/data.txt")

    Enum.map(stream, &fix_value!(&1))
    |> Enum.sum()
  end

  def fix_value!(line) when is_bitstring(line) do
    # IO.inspect(line)

    String.trim(line)
    |> replace_words_with_numbers()
    |> (fn value ->
          # IEx.pry()
          # IO.inspect(value)
          value
        end).()
    # convert to a list of graphemes (characters)
    |> String.graphemes()
    # reduce to only a list of numbers in order (discard non-numbers)
    |> to_ordered_numbers()
    |> combine_first_and_last()
    |> (fn value ->
          # IEx.pry()
          # IO.inspect(value)
          value
        end).()
    |> String.to_integer()
  end

  def replace_words_with_numbers(text) when is_binary(text) do
    String.graphemes(text)
    |> Enum.join("")
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
  Takes a list of strings, attempts to convert each string to an integer,
  and accumulates only the successful conversions in reverse order.
  The accumulated list is then reversed to restore the original order.
  """
  def to_ordered_numbers(line) when is_list(line) do
    Enum.reduce(line, [], fn char, acc ->
      try do
        # This is my (probably stupid) way of figuring out if the string is a number
        _ = String.to_integer(char)
        # If it is a number then add it to the accumulator
        # prepending is faster than appending so we reverse the list at the end
        [char | acc]
      rescue
        ArgumentError ->
          acc
      end
    end)
    |> Enum.reverse()
  end
end
