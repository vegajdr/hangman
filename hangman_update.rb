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
  if guessesdb.include?(guess) && guess != ""
    puts "You've already guessed that letter, please guess again"
  elsif guess.length > 1
    puts "Please type just *ONE* character! Are you trying to cheat?"
  elsif guess == ""
    puts "You didn't type anything, please choose a letter"
  end
end
def correct_guess word, guess, board
  i = 0
  word.each do |l|
    if guess == l
      board[i] = guess
    end
    i += 1
  end
end
def attempts_count guessesdb, guess, word
  unless guessesdb.include?(guess) || word.include?(guess) || guess.length > 1 || guess == ""
    return true
  end
end
def replay confirm
  gamedone = nil
  unless confirm.downcase == "y"
    gamedone = true
    return gamedone
  end
  gamedone
end
def display board
  board.each do |letter|
    print letter
  end
end
wordsdb = database_create
board = []
input = nil
done = nil# Actual game starts here:
until done do
  attempts = 6
  word = []
  board.clear
  guessesdb.clear
  word = wordsdb.sample
  board = board_create word
  puts "\nPlease type in a letter to guess the word:"
  until win?(board, word, attempts) #== word || attempts == 0#attempts taken do
    guess = gets.chomp
    puts word.join
    check_invalid_guess guessesdb, guess
    correct_guess word, guess, board
    attempts -= 1 if attempts_count guessesdb, guess, word
    display board
    puts "\nYou have #{attempts} attempts left!"
    guessesdb.push(guess)
  end
  match board, word, attempts
  puts "Would you like to play again?:y/n"
  confirm = gets.chomp
  done = replay(confirm)
end
