require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze

WHO_PLAYS_FIRST = 'choose'.freeze

score = { "player" => 0, "computer" => 0 }

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(msg)
  puts "=> + #{msg}"
end

def joinor(arr, delimiter=',', word = 'or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def display_board(brd)
  system 'clear'
  puts "<-----------------> Tic Tac Toe <----------------->"
  puts "You play with #{PLAYER_MARKER}, computer plays with #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a position: #{joinor(empty_squares(brd), ', ')}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

# Rubocop dislikes the "else nil" above but refactored version below appears less readable
# def find_at_risk_square(line, board, marker)
#   return board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first if 
#   board.values_at(*line).count(marker) == 2
# end

def computer_places_piece!(brd)
  square = nil

  # Offense
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  # Defense
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  # If no defensive or offensive play exists, go for board[5] > random
  if brd[5] == ' '
    square = 5
  elsif !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def update_score(score_hash, winner)
  if winner == 'Player'
    score_hash["player"] += 1
  elsif winner == 'Computer'
    score_hash["computer"] += 1
  end
end

def win_prompt(score_hash)
  if score_hash["player"] == 2
    prompt "You win the game!"
  elsif score_hash["computer"] == 2
    prompt "Computer won. :("
  end
end

def continue?
  gets.chomp
end

def place_piece!(brd, current_player)
  if current_player == 'player'
    player_places_piece!(brd)
  elsif current_player == 'computer'
    computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  if current_player == 'player'
    current_player = 'computer'
  elsif current_player == 'computer'
    current_player = 'player'
  end
end

def results_prompt(winner)
  if winner
    prompt "#{winner} won!"
  else
    prompt "It's a tie..."
  end
end

current_player = ''

loop do
  prompt "Who will play first? (player or computer)"
  current_player = gets.chomp.downcase
  break if current_player == 'player' || current_player == 'computer'
end

loop do # Restart 2 win loop
  score = { "player" => 0, "computer" => 0 }

  loop do # Continue playing to 2 win loop
    board = initialize_board

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    results_prompt(detect_winner(board))

    update_score(score, detect_winner(board))

    prompt "Player: #{score['player']} vs Computer: #{score['computer']}"

    win_prompt(score)

    break if score["player"] == 2 || score["computer"] == 2

    prompt "Continue playing to 2? (y or n)"
    break unless continue? == 'y'
  end

  prompt "Play to 2 again? (y or n)"
  break unless continue? == 'y'
end

prompt "Thanks for playing!"
