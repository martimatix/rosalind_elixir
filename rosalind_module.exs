# Module for shared functions used in Rosalind problems

defmodule Rosalind do
  @rna_codon_table %{
    'UUU' => 'F',     'CUU' => 'L',      'AUU' => 'I',      'GUU' => 'V',
    'UUC' => 'F',     'CUC' => 'L',      'AUC' => 'I',      'GUC' => 'V',
    'UUA' => 'L',     'CUA' => 'L',      'AUA' => 'I',      'GUA' => 'V',
    'UUG' => 'L',     'CUG' => 'L',      'AUG' => 'M',      'GUG' => 'V',
    'UCU' => 'S',     'CCU' => 'P',      'ACU' => 'T',      'GCU' => 'A',
    'UCC' => 'S',     'CCC' => 'P',      'ACC' => 'T',      'GCC' => 'A',
    'UCA' => 'S',     'CCA' => 'P',      'ACA' => 'T',      'GCA' => 'A',
    'UCG' => 'S',     'CCG' => 'P',      'ACG' => 'T',      'GCG' => 'A',
    'UAU' => 'Y',     'CAU' => 'H',      'AAU' => 'N',      'GAU' => 'D',
    'UAC' => 'Y',     'CAC' => 'H',      'AAC' => 'N',      'GAC' => 'D',
    'UAA' => :Stop,   'CAA' => 'Q',      'AAA' => 'K',      'GAA' => 'E',
    'UAG' => :Stop,   'CAG' => 'Q',      'AAG' => 'K',      'GAG' => 'E',
    'UGU' => 'C',     'CGU' => 'R',      'AGU' => 'S',      'GGU' => 'G',
    'UGC' => 'C',     'CGC' => 'R',      'AGC' => 'S',      'GGC' => 'G',
    'UGA' => :Stop,   'CGA' => 'R',      'AGA' => 'R',      'GGA' => 'G',
    'UGG' => 'W',     'CGG' => 'R',      'AGG' => 'R',      'GGG' => 'G',
  }

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

  def rna_to_protein(rna) do
    rna
      |> Stream.chunk(3)
      |> Stream.map(&(@rna_codon_table[&1]))
      |> Stream.take_while(&(&1 != :Stop))
      |> Enum.to_list
  end
end
