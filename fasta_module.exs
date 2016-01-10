# Module for parsing FASTA files

defmodule Fasta do

  def read(filename) do
    # Returns a map with the FASTA label as a key and
    # the FASTA string as the value
    File.stream!(filename)
      |> Stream.map(fn(line) -> String.rstrip(line) end)
      |> compile
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
