# Module for shared functions used in Rosalind problems

defmodule Rosalind do
  def dna_to_rna(dna) do
    String.replace(dna, "T", "U")
  end

  def complement(symbol) do
    case symbol do
      "A" -> "T"
      "C" -> "G"
      "G" -> "C"
      "T" -> "A"
    end
  end
end
