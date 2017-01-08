my_name = "Ian"

puts my_name

loop do
  my_name << " Lawson"
  puts "Type 'y' to exit loop"
  answer = gets.chomp.downcase
  break if answer == 'y'
end

puts "My name after loop / block:"
puts my_name

def test_meth(first, second)
  first + second
end


loop do
  my_name = test_meth(1, 2)
  puts "Type 'y' to exit loop"
  answer = gets.chomp.downcase
  break if answer == 'y'
end

puts "My name after second loop / block:"
puts my_name