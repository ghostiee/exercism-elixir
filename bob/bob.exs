defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      question?(input) and yelling?(input) ->
        "Calm down, I know what I'm doing!"
      yelling?(input)-> "Whoa, chill out!"
      question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  def question?(input) do
    String.ends_with? input, "?"
  end
  
  def yelling?(input) do
   Regex.match?(~r/\p{L}+/, input) and
   String.upcase(input) === input
  end

  def silence?(input) do
   String.trim(input) === ""
  end
end
