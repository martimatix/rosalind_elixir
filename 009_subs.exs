# Problem
#
# Given two strings ss and tt, tt is a substring of ss if tt is contained as a
# contiguous collection of symbols in ss (as a result, tt must be no longer than
# ss).
#
# The position of a symbol in a string is the total number of symbols found to its
# left, including itself (e.g., the positions of all occurrences of 'U' in
# "AUGCUUCAGAAAGGUCUUACG" are 2, 5, 6, 15, 17, and 18). The symbol at position ii
# of ss is denoted by s[i]s[i].
#
# A substring of ss can be represented as s[j:k]s[j:k], where jj and kk represent
# the starting and ending positions of the substring in ss; for example, if ss =
# "AUGCUUCAGAAAGGUCUUACG", then s[2:5]s[2:5] = "UGCU".
#
# The location of a substring s[j:k]s[j:k] is its beginning position jj; note that
# tt will have multiple locations in ss if it occurs more than once as a substring
# of ss (see the Sample below).
#
# Given: Two DNA strings ss and tt (each of length at most 1 kbp).
#
# Return: All locations of tt as a substring of ss.
#
# Sample Dataset
# GATATATGCATATACTT
# ATAT
#
# Sample Output
# 2 4 10

defmodule Subs do
  @s 'GATATATGCATATACTT'
  @t 'ATAT'
  @length_t length(@t)

  def solve, do: solve(@s, 1, "")

  def solve(s, index, acc) when length(s) >= @length_t do
    [ _ | tail ] = s
    case Enum.take(s, @length_t) do
      @t -> solve(tail, index + 1, acc <> "#{index} ")
      _  -> solve(tail, index + 1, acc)
    end
  end

  def solve(_, _, acc), do: acc
end

IO.puts Subs.solve
