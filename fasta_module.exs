# Module for parsing FASTA files

defmodule Fasta do
  defstruct id: "FASTA", value: ""

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

  def compile(lines) do
    Enum.reduce(lines, [], fn(line, acc) ->
      case String.first(line) do
        ">" ->
          # Remove ">" character from label
          fasta_id = String.lstrip(line, ?>)
          acc = [ %Fasta{id: fasta_id} | acc ]
        _ ->
          [ fasta | tail ] = acc
          acc = [ %{fasta | value: fasta.value <> line} | tail ]
      end
    end)
  end
end
