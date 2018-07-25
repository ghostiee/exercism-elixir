defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    do_of_rna(rna, [])
  end

  def do_of_rna("", proteins), do: {:ok, proteins}

  def do_of_rna(<<codon::binary-size(3), rest::binary>>, proteins) do
    case of_codon(codon) do
      {:error, _} -> {:error, "invalid RNA"}
      {:ok, "STOP"} -> {:ok, proteins}
      {:ok, protein} -> do_of_rna(rest, proteins ++ [protein])
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """

  @codon2Proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@codon2Proteins, codon) do
      :error -> {:error, "invalid codon"}
      res -> res
    end
  end
end
