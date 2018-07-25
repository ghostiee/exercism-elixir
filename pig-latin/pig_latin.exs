defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase, " ")
    |> Enum.map(&do_translate/1)
    |> Enum.join(" ")
  end

  def do_translate(<<"x", alphabet::binary-size(1), rest::binary>>) do
    case is_vowel(alphabet) do
      true -> "#{alphabet}#{rest}xay"
      false -> "x#{alphabet}#{rest}ay"
    end
  end

  def do_translate(<<"y", alphabet::binary-size(1), rest::binary>>) do
    case is_vowel(alphabet) do
      true -> "#{alphabet}#{rest}yay"
      false -> "y#{alphabet}#{rest}ay"
    end
  end

  def do_translate(<<"qu", rest::binary>>) do
    do_translate("#{rest}qu")
  end

  def do_translate(<<alphabet::binary-size(1), rest::binary>>) do
    case is_vowel(alphabet) do
      true -> alphabet <> rest <> "ay"
      false -> do_translate(rest <> alphabet)
    end
  end

  def is_vowel(alphabet) do
    alphabet in ["a", "e", "i", "o", "u"]
  end
end
