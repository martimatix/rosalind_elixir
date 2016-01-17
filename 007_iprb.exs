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

# Mario's note:
Although there is a mathematical formula to solve this problem almost
instantaneously, from a programming perspective it is far more interesting to
obtain the answer by simulation. Hence, that is the method shown below. Warning:
execution time is slow!

defmodule MendelFirstLaw do
  @dataset [{'k', 2}, {'m', 2}, {'n', 2}]
  @trials 3000000

  def solve do
    Enum.reduce(@dataset, [], fn(organism, acc) -> acc ++ make_copies(organism) end)
      |> conduct_trials
      |> Enum.sum
      |> calculate_probability
  end

  def conduct_trials(organisms) do
    Enum.map((0..@trials), fn(x) ->  Enum.take_random(organisms, 2)
                                      |> probabilitiy_homozygous_dominant end)
  end

  def make_copies(organism) do
    List.duplicate(elem(organism, 0), elem(organism, 1))
  end

  def probabilitiy_homozygous_dominant(organisms) do
    case organisms do
      ['n', 'n'] -> 0
      ['n', 'm'] -> 0.5
      ['m', 'n'] -> 0.5
      ['m', 'm'] -> 0.75
      _ -> 1
    end
  end

  def calculate_probability(num_homozygous_dominant) do
    num_homozygous_dominant / @trials
  end
end

IO.puts MendelFirstLaw.solve
