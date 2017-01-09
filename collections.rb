str = 'The grass is green'
str[4, 5]
str.slice(4, 5)
# returns string

arr = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
arr[2, 3] # returns array
arr[2, 3][0] # returns string of the 0 indexed value in arr[2, 3]

hsh = { 'fruit' => 'apple', 'vegetable' => 'carrot' }

hsh['fruit']    # => "apple"
hsh['fruit'][0] # => "a"

country_capitals = { UK: 'London', France: 'Paris', Germany: 'Berlin' }
country_capitals.keys      # => [:UK, :France, :Germany]
country_capitals.values    # => ["London", "Paris", "Berlin"]
country_capitals.values[0] # => "London"

str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']

str[2] # => "c"
arr[2] # => "c"

# The indices of both of these collections run from 0 to 4. 
# What if we try to reference using an index greater than 4?

str[5] # => nil
arr[5] # => nil

arr.fetch(2) # => nil
arr.fetch(3) # => IndexError: index 3 outside of array bounds: -3...3
             #        from (irb):3:in `fetch'
             #        from (irb):3
             #        from /usr/bin/irb:11:in `<main>'

# Elements in String and Array objects can be referenced 
# using negative indices, starting from the last index in the collection -1 and working backwards.

hsh = { :a => 1, 'b' => 'two', :c => nil }

hsh['b']       # => "two"
hsh[:c]        # => nil
hsh['c']       # => nil
hsh[:d]        # => nil

hsh.fetch(:c)  # => nil
hsh.fetch('c') # => KeyError: key not found: "c"
               #        from (irb):2:in `fetch'
               #        from (irb):2
               #        from /usr/bin/irb:11:in `<main>'
hsh.fetch(:d)  # => KeyError: key not found: :d
               #        from (irb):3:in `fetch'
               #        from (irb):3
               #        from /usr/bin/irb:11:in `<main>'

str = 'Practice'
arr = str.chars # => ["P", "r", "a", "c", "t", "i", "c", "e"]
arr.join # => "Practice"

str = 'How do you get to Carnegie Hall?'
arr = str.split # => ["How", "do", "you", "get", "to", "Carnegie", "Hall?"]
arr.join        # => "HowdoyougettoCarnegieHall?"
arr.join(' ')   # => "How do you get to Carnegie Hall?"

hsh = { sky: "blue", grass: "green" }
hsh.to_a # => [[:sky, "blue"], [:grass, "green"]]

arr = [[:name, 'Joe'], [:age, 10], [:favorite_color, 'blue']]
arr.to_h # => {:name=>"Joe", :age=>10, :favorite_color=>"blue"}

str = "joe's favorite color is blue"
str[0] = 'J'
str # => "Joe's favorite color is blue"
