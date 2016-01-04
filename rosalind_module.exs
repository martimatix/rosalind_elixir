# Module for shared functions used in Rosalind problems

defmodule Rosalind do
  def dna_to_rna(dna) do
    String.replace(dna, "T", "U")
  end
end
