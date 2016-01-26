# Problem
#
# Given two strings ss and tt of equal length, the Hamming distance between ss and
# tt, denoted dH(s,t)dH(s,t), is the number of corresponding symbols that differ
# in ss and tt. See Figure 2.
#
# Given: Two DNA strings ss and tt of equal length (not exceeding 1 kbp).
#
# Return: The Hamming distance dH(s,t)dH(s,t).
#
# Sample Dataset
# GAGCCTACTAACGGGAT
# CATCGTAATGACGGCCT
#
# Sample Output
# 7

dna1 = 'GAGCCTACTAACGGGAT'
dna2 = 'CATCGTAATGACGGCCT'

Enum.zip(dna1, dna2)
|> Enum.count(&(elem(&1, 0) != elem(&1, 1)))
|> IO.inspect
