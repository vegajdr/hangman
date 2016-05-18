require "pry"
print "Let's play hangman!, a man's life lays on your hands"
guessesdb = []

def database_create
  db = []
  File.open("/usr/share/dict/words") do |f|
    f.each_line do |line|
      db.push line.chomp.downcase.split("")
    end
  end
  db
end
def board_create word
  board = []
    word.each do
      board.push "_"
    end
    board
end
def win? board, word, attempts
  if board == word || attempts == 0
    return true
  end
  return false
end
def match board, word, attempts
  if board == word
    puts "You have guessed the word! You shall be proclaimed hero among many!"
  elsif attempts == 0
    puts "You have killed the poor innocent man, hope you can sleep at night!"
    puts "All you had to do was guess the word: #{word.join}"
  end
end
def check_invalid_guess guessesdb, guess
  if guessesdb.include?(guess)
    puts "You've already guessed that letter, please guess again"
  elsif guess.length > 1
    puts "Please type just *ONE* character! Are you trying to cheat?"
  end
end
def result
end

wordsdb = database_create
board = []
input = nil
# Actual game starts here:
gamedone = false
until gamedone do
  attempts = 6
  word = []
  board.clear
  word = wordsdb.sample
  board = board_create word

  puts

  puts "Please type in a letter to guess the word:"

  until win?(board, word, attempts) #== word || attempts == 0#attempts taken do
    guess = gets.chomp
    puts word.join

    check_invalid_guess guessesdb, guess

#------- Potential method
    i = 0
    word.each do |l|
      if guess == l
        board[i] = guess
      end
      i += 1
    end
    i = 0
    unless guessesdb.include?(guess) || word.include?(guess) || guess.length > 1
      attempts -= 1
    end
#-------------------------

    board.each do |letter|
      print letter
    end
    puts
    puts "You have #{attempts} attempts left!"
    guessesdb.push(guess)
  end

  match board, word, attempts

  puts "Would you like to play again?:y/n"
  replay = gets.chomp
  unless replay.downcase == "y"
    gamedone = true
  end

end
#binding.pry
