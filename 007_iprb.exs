# Problem
#
# Given: Three positive integers kk, mm, and nn, representing a population
# containing k+m+nk+m+n organisms: kk individuals are homozygous dominant for a
# factor, mm are heterozygous, and nn are homozygous recessive.
#
# Return: The probability that two randomly selected mating organisms will produce
# an individual possessing a dominant allele (and thus displaying the dominant
# phenotype). Assume that any two organisms can mate.
#
# Sample Dataset
# 2 2 2
#
# Sample Output
# 0.78333

defmodule MendelFirstLaw do
  @k 2
  @m 2
  @n 2
  @dataset [{'k', @k }, {'m', @m}, {'n', @n}]
  @num_organisms @k + @m + @n

  def solve do
    Enum.reduce(@dataset, [], fn(organism, acc) -> acc ++ make_copies(organism) end)
      |> Enum.with_index
      |> mate_organisms
      |> Enum.sum
      |> calculate_probability
  end

  defp make_copies(organism) do
    List.duplicate(elem(organism, 0), elem(organism, 1))
  end

  # Mate every organism with another
  defp mate_organisms(organisms) do
    for x <- organisms,
        y <- organisms,
        elem(x, 1) != elem(y, 1),
        do: probabilitiy_homozygous_dominant({elem(x, 0), elem(y, 0)})
  end

  defp probabilitiy_homozygous_dominant(pair) do
    case pair do
      {'n', 'n'} -> 0
      {'n', 'm'} -> 0.5
      {'m', 'n'} -> 0.5
      {'m', 'm'} -> 0.75
      _ -> 1
    end
  end

  defp calculate_probability(num_successes) do
    # We use `@num_organisms - 1` to ignore the cases where the organism
    # would have mated with iteslf
    num_trials = @num_organisms * (@num_organisms - 1)
    num_successes / num_trials
  end
end

IO.puts MendelFirstLaw.solve
