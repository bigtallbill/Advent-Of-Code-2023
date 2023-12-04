defmodule AOC do
  require IEx

  def p1 do
    stream = File.stream!("d1/data.txt")

    Enum.map(stream, &fix_value!(&1))
    |> Enum.sum()
  end

  def replace_words_with_numbers(text) do
    String.graphemes(text)
    |>
  end

  def fix_value!(line) do
    IO.inspect(line)

    String.trim(line)
    |> __MODULE__.replace_words_with_numbers()
    |> (fn value ->
          # IEx.pry()
          IO.inspect(value)
          value
        end).()
    # convert to a list of graphemes (characters)
    |> String.graphemes()
    # reduce to only a list of numbers in order (discard non-numbers)
    |> Enum.reduce([], fn char, acc ->
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
    |> case do
      # If we have no values then something is wrong
      [] -> raise("bah humbug")
      # If we have only 1 value then it is both "first" and "last" so we combine it with itself
      [one_value] -> one_value <> one_value
      # If we have more than 1 value then get and combine only the first and last
      [head | tail] -> head <> (Enum.reverse(tail) |> Enum.at(0))
    end
    |> (fn value ->
          # IEx.pry()
          IO.inspect(value)
          value
        end).()
    |> String.to_integer()
  end
end

IO.inspect(AOC.p1())
