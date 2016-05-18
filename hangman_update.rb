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
def win? board, word, attempts, solution
  if board == word || attempts == 0 || solution == true
    return true
  end
  return false
end
def match board, word, attempts, solution
  if board == word || solution
    puts "You have guessed the word! You shall be proclaimed hero among many!"
  elsif attempts == 0
    puts "You have killed the poor innocent man, hope you can sleep at night!"
    puts "All you had to do was guess the word: #{word.join}"
  end
end
def check_invalid_guess guessesdb, guess
  if guessesdb.include?(guess) && guess != "" && guess != ":solve"
    puts "You've already guessed that letter, please guess again"
  elsif guess.length > 1 && guess != ":solve"
    puts "Please type just *ONE* character! Are you trying to cheat?"
  elsif guess == ""
    puts "You didn't type anything, please choose a letter"
  elsif guess == ":solve"
    puts "That's a bold move!"
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
def full_solve guess, board
  answer = nil
  if guess == ":solve"
    answer = gets.chomp.split("")
    if answer == board
      return true
    end#end the game as win

  end
  false
end

wordsdb = database_create
board = []
done = nil# Actual game starts here:
until done do
  attempts = 6
  word = []
  board.clear
  guessesdb.clear
  word = wordsdb.sample
  board = board_create word
  solution = false
  puts "\nPlease type in a letter to guess the word"
  puts "(*NOTE: Type ':solve' to guess full word:)"
  until win?(board, word, attempts, solution) #== word || attempts == 0#attempts taken do
    guess = gets.chomp

    solution = full_solve guess, word
    p solution
    # unless full_solve guess == nil
    #   guess = full_solve guess
    # end
    #guess = full_solve guess
    puts word.join
    check_invalid_guess guessesdb, guess
    correct_guess word, guess, board
    attempts -= 1 if attempts_count guessesdb, guess, word
    display board
    puts "\nYou have #{attempts} attempts left!"
    guessesdb.push(guess)
    match board, word, attempts, solution
  end
  # match board, word, attempts
  puts "Would you like to play again?:y/n"
  confirm = gets.chomp
  done = replay(confirm)
end
