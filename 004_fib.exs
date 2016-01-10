# Return: The total number of rabbit pairs that will be present after nn months if
# we begin with 1 pair and in each generation, every pair of reproduction-age
# rabbits produces a litter of kk rabbit pairs (instead of only 1 pair).
#
# Sample Dataset
# 5 3
#
# Sample Output
# 19

{n, k} = {5, 3}

fib = Stream.unfold({1, 1}, fn {a, b} -> {a, {b, k * a + b}} end)
fib
  |> Enum.take(n)
  |> List.last
  |> IO.inspect
