defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    case dna do
     'A' -> 'U'
     'C' -> 'G'
     'T' -> 'A'
     'G' -> 'C'
      _ -> Enum.reduce(dna, '', fn (r, acc) -> acc ++ to_rna([r]) end)
    end
  end
end
