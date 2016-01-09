# Module for shared functions used in Rosalind problems

defmodule Rosalind do
  def dna_to_rna(dna), do: String.replace(dna, "T", "U")

  def complement(symbol) do
    case symbol do
      "A" -> "T"
      "C" -> "G"
      "G" -> "C"
      "T" -> "A"
    end
  end

  def gc_content(dna) do
    gc_count = dna
                |> String.codepoints
                |> Enum.count(&(&1 == "G" || &1 == "C"))
    gc_count / String.length(dna) * 100
  end
end
