

# .any?

[1, 2, 3].any? do |num|
  num > 2
end
# => true

{ a: "ant", b: "bear", c: "cat" }.any? do |key, value|
  value.size > 4
end
# => false




# .all?

[1, 2, 3].all? do |num|
  num > 2
end
# => false

{ a: "ant", b: "bear", c: "cat" }.all? do |key, value|
  value.length >= 3
end
# => true



{ a: "ant", b: "bear", c: "cat" }.each_with_index do |pair, index|
  puts "The index of #{pair} is #{index}."
end

# The index of [:a, "ant"] is 0.
# The index of [:b, "bear"] is 1.
# The index of [:c, "cat"] is 2.
# => { :a => "ant", :b => "bear", :c => "cat" }



odd, even = [1, 2, 3].partition do |num|
  num.odd?
end
# => [[1, 3], [2]]

odd  # => [1, 3]
even # => [2]


short, long = { a: "ant", b: "bear", c: "cat" }.partition do |key, value|
  value.size > 3
end
# => [[[:b, "bear"]], [[:a, "ant"], [:c, "cat"]]]

short.to_h # => { :b => "bear" }
long.to_h  # => { :a => "ant", :c => "cat" }