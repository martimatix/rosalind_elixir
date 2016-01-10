# Module for parsing FASTA files

defmodule Fasta do

  # Returns a list of tuples - first element is the FASTA label
  # and second is the FASTA string
  def read(filename) do
    File.stream!(filename)
      |> Stream.map(fn(line) -> String.rstrip(line) end)
      |> compile
  end


  # Returns a single tuple - for when there is only FASTA in the file
  def read(filename, :single) do
    read(filename)
      |> List.first
  end

  # Returns a map with the FASTA label as a key and
  # the FASTA string as the value
  def read(filename, :map) do
    read(file)
      |> Enum.into(%{})
  end

  def compile(lines) do
    Enum.reduce(lines, [], fn(line, acc) ->
      case String.first(line) do
        ">" ->
          # Remove ">" character from label
          fasta_label = String.lstrip(line, ?>)
          acc = [ {fasta_label, ""} | acc ]
        _ ->
          [ tuple | tail ] = acc
          fasta_value = elem(tuple, 1) <> line
          acc = [ put_elem(tuple, 1, fasta_value) | tail ]
      end
    end)
  end
end
