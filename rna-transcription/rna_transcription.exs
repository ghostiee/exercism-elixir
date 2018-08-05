defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """

  @dna_to_rna_map %{
    ?A => ?U,
    ?C => ?G,
    ?T => ?A,
    ?G => ?C
  }

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &@dna_to_rna_map[&1])
  end
end
