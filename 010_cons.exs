# Work in Progress - Not completed!

# Problem
#
# A matrix is a rectangular table of values divided into rows and columns. An
# m×nm×n matrix has mm rows and nn columns. Given a matrix AA, we write Ai,jAi,j
# to indicate the value found at the intersection of row ii and column jj.
#
# Say that we have a collection of DNA strings, all having the same length nn.
# Their profile matrix is a 4×n4×n matrix PP in which P1,jP1,j represents the
# number of times that 'A' occurs in the jjth position of one of the strings,
# P2,jP2,j represents the number of times that C occurs in the jjth position, and
# so on (see below).
#
# A consensus string cc is a string of length nn formed from our collection by
# taking the most common symbol at each position; the jjth symbol of cc therefore
# corresponds to the symbol having the maximum value in the jj-th column of the
# profile matrix. Of course, there may be more than one most common symbol,
# leading to multiple possible consensus strings.

# Sample Dataset
#
# >Rosalind_1
# ATCCAGCT
# >Rosalind_2
# GGGCAACT
# >Rosalind_3
# ATGGATCT
# >Rosalind_4
# AAGCAACC
# >Rosalind_5
# TTGGAACT
# >Rosalind_6
# ATGCCATT
# >Rosalind_7
# ATGGCACT


# Sample Output
#
# ATGCAACT
# A: 5 1 0 0 5 5 0 0
# C: 0 0 1 4 2 0 6 1
# G: 1 1 6 3 0 1 0 0
# T: 1 5 0 0 0 1 1 6

# Note: this is not the optimal nor the clearest way to obtain the answer
# However, my aim here was to play round with Elixir processes

Code.require_file "rosalind_module.exs", __DIR__
Code.require_file "fasta_module.exs", __DIR__

defmodule Cons do
  @fasta Fasta.read("rosalind_cons.txt")
  @dna_string_length (List.first(@fasta)).value |> String.length

  def perform do
    {:ok, pid} = Matrix.start_link(@dna_string_length)
    Process.register(pid, :matrix)

    @fasta
      |> Enum.each(fn(fasta) ->
                    spawn(fn -> fasta.value
                                |> String.split("", trim: true)
                                |> Enum.with_index
                                |> Enum.each(fn({symbol, index}) -> send(:matrix, {:increment, symbol, index}) end)
                          end)
                  end)

    # Wait a moment for things to process - ideally we should be using a supervisor here
    # I acknowledge that this is a very bad pattern but it's my first time using processes!
    :timer.sleep(10)

    send(:matrix, {:get_map, self()})
    result = receive do
      {matrix} -> matrix
      _ -> 'empty'
    end
    IO.inspect(result)

    # TODO: Calculate the statistical mode for each column and present them in
    #       the format that Rosalind expects the answer
  end
end

defmodule Matrix do
  def start_link(dna_string_length) do
    Task.start_link(fn -> loop(initial_matrix(dna_string_length)) end)
  end

  defp loop(map) do
    receive do
      {:increment, symbol, index} ->
        key = String.to_atom(symbol)
        updated_map = Map.update(map, key, nil, fn(frequency_array) ->
          List.update_at(frequency_array, index, &(&1 + 1))
        end)
        loop(updated_map)
      {:get_map, caller} ->
        send(caller, {map})
        loop(map)
    end
  end

  defp initial_matrix(dna_string_length) do
    %{A: list_of_zeros(dna_string_length),
      C: list_of_zeros(dna_string_length),
      G: list_of_zeros(dna_string_length),
      T: list_of_zeros(dna_string_length)}
  end

  defp list_of_zeros(dna_string_length) do
    List.duplicate(0, dna_string_length)
  end
end

Cons.perform
