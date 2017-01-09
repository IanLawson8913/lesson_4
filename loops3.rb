# produce = {
#   'apple' => 'Fruit',
#   'carrot' => 'Vegetable',
#   'pear' => 'Fruit',
#   'broccoli' => 'Vegetable'
# }

# def general_select(produce_list, selection_criteria)
#   produce_keys = produce_list.keys
#   counter = 0
#   selected_fruits = {}

#   loop do
#     break if counter == produce_keys.size      

#     current_key = produce_keys[counter]
#     current_value = produce_list[current_key]

#     # used to be current_value == 'Fruit'
#     if current_value == selection_criteria   
#       selected_fruits[current_key] = current_value
#     end

#     counter += 1
#   end

#   selected_fruits
# end

####

# require 'pry'

# my_numbers = [1, 4, 3, 7, 2, 6]

# def multiply(arr, multiple)
#   multiplied_numbers = []
#   counter = 0

#   loop do
#     multiplied_numbers << arr[counter] *= multiple
    
#     counter += 1
#     break if arr.length == counter
#   end

#   multiplied_numbers
# end

# puts multiply(my_numbers, 3) # => [3, 12, 9, 21, 6, 18]

####

def select_letter(sentence, character)
  selected_chars = ''
  counter = 0

  loop do
    break if counter == sentence.size
    current_char = sentence[counter]

    if current_char == character
      selected_chars << current_char
    end

    counter += 1
  end

  selected_chars
end

question = 'How many times does a particular character appear in this sentence?'