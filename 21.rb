require 'pry'

SUITS = ['H', 'D', 'S', 'C'].freeze
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].freeze
SCORE_LIMIT = 2
VALUE_LIMIT = 21
DEALER_STAY = 17

score = { player: 0, dealer: 0 }

def prompt(msg)
  puts "---  #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += if value == 'A'
             11
           elsif value.to_i.zero?
             10
           else
             value.to_i
           end
  end

  # correct for Ace
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > VALUE_LIMIT
  end

  sum
end

def update_score(dealer_cards, player_cards, score)
  result = detect_results(dealer_cards, player_cards)

  case result
  when :dealer_busted, :player
    score[:player] += 1
  when :player_busted, :dealer
    score[:dealer] += 1
  end
end

def final_score_reached?(score)
  score[:player] == SCORE_LIMIT || score[:dealer] == SCORE_LIMIT
end

def busted?(cards)
  total(cards) > VALUE_LIMIT
end

def play_again?(score)
  puts "<-------------------------------------->"
  if final_score_reached?(score)
    prompt "Play to #{SCORE_LIMIT} again?"
  else
    prompt "Continue playing to #{SCORE_LIMIT}? (y or n)"
  end
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def detect_results(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > VALUE_LIMIT
    :player_busted
  elsif dealer_total > VALUE_LIMIT
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def win_lose_message(dealer_cards, player_cards)
  result = detect_results(dealer_cards, player_cards)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def grand_output(dealer_hand, player_hand, hand_totals)
  puts "<-------------------------------------->"
  prompt "Dealer has #{dealer_hand}, for a total of: #{hand_totals[:dealer]}"
  prompt "Player has #{player_hand}, for a total of: #{hand_totals[:player]}"
  puts "<-------------------------------------->"
end

def update_hand_totals(player_cards, dealer_cards, hand_totals)
  hand_totals[:player] = total(player_cards)
  hand_totals[:dealer] = total(dealer_cards)
end

def first_deal(deck, player_cards, dealer_cards, hand_totals)
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end
  update_hand_totals(player_cards, dealer_cards, hand_totals)

  prompt "Dealer has: #{dealer_cards[0]} and ?"
  prompt "You have: #{player_cards[0]} and a #{player_cards[1]}. Total: #{hand_totals[:player]}"
end

def hit_or_stay
  answer = nil
  loop do
    prompt "(h)it or (s)stay?       ---"
    answer = gets.chomp.downcase
    break if ['h', 's'].include?(answer)
    prompt "Sorry, must enter 'h' or 's'."
  end

  answer
end

# Player / Dealer Logic
def player_hits(deck, player_cards, dealer_cards, hand_totals)
  player_cards << deck.pop
  update_hand_totals(player_cards, dealer_cards, hand_totals)
end

def player_hits_output(player_cards, hand_totals)
  prompt "You chose to hit!"
  prompt "Your cards are now: #{player_cards}"
  prompt "Your total is now: #{hand_totals[:player]}"
end

def player_end_turn_output(player_cards, hand_totals)
  if busted?(player_cards)
    prompt "Woops..."
  else
    prompt "You chose to stay at #{hand_totals[:player]}"
  end
end

def dealer_hits(deck, player_cards, dealer_cards, hand_totals)
  dealer_cards << deck.pop
  update_hand_totals(player_cards, dealer_cards, hand_totals)
end

def dealer_hits_output(dealer_cards)
  prompt "Dealer hits!"
  prompt "Dealer's cards are now: #{dealer_cards}"
end

def dealer_end_turn_output(dealer_cards, hand_totals)
  if busted?(dealer_cards)
    prompt "Dealer total is now: #{hand_totals[:dealer]}"
  else
    prompt "Dealer stays at #{hand_totals[:dealer]}"
  end
end

def display_board(score)
  system 'clear'
  prompt "----------------------- ---"
  prompt "Welcome to Twenty-One!  ---"
  prompt "----------------------- ---"
  prompt "Player: #{score[:player]} Dealer: #{score[:dealer]}     ---"
  prompt "----------------------- ---"
end

# Main Loop
loop do
  score = { player: 0, dealer: 0 }

  loop do
    # initialize varfirst_deal(deck, player_cards, dealer_cards, hand_totals)
    deck = initialize_deck
    player_cards = []
    dealer_cards = []
    hand_totals = { player: 0, dealer: 0 }
    display_board(score)

    # initial deal
    first_deal(deck, player_cards, dealer_cards, hand_totals)

    # Player turn
    loop do
      player_turn = hit_or_stay

      if player_turn == 'h'
        player_hits(deck, player_cards, dealer_cards, hand_totals)
        player_hits_output(player_cards, hand_totals)
        update_hand_totals(player_cards, dealer_cards, hand_totals)
      end

      break if player_turn == 's' || busted?(player_cards)
    end

    player_end_turn_output(player_cards, hand_totals)

    # Dealer's Turn
    prompt "Dealer's turn..."

    # Dealer hits until total is DEALER_STAY or higher || busts
    loop do
      break if busted?(dealer_cards) || total(dealer_cards) >= DEALER_STAY
      dealer_hits(deck, player_cards, dealer_cards, hand_totals)
      dealer_hits_output(dealer_cards)
      update_hand_totals(player_cards, dealer_cards, hand_totals)
    end

    dealer_end_turn_output(dealer_cards, hand_totals)

    grand_output(dealer_cards, player_cards, hand_totals)
    win_lose_message(dealer_cards, player_cards)
    update_score(dealer_cards, player_cards, score)

    break if final_score_reached?(score) || !play_again?(score)
  end

  break unless play_again?(score)
end

prompt "Thank you for playing Twenty-One! Have a nice day...or night!"
