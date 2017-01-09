# Calls the given block once for each element in self, passing that element as a parameter. 
# Returns the array itself.

[1, 2, 3].each do |num|
  puts num + 2
end

3
4
5
# => [1, 2, 3]

# Returns a new array containing all elements of ary for which the given block returns a true value.

[1, 2, 3].select do |num|
  num < 3
end
# => [1, 2]


# Invokes the given block once for each element of self.
# Creates a new array containing the values returned by the block.

[1, 2, 3].map do |num|
  num + 1
end
# => [2, 3, 4]

