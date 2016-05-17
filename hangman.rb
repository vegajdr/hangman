require "pry"
print "Let's play hangman!, a man's life lays on your hands"
wordsdb = []
guesses = []

File.open("/usr/share/dict/words") do |f|
  f.each_line do |line|
    wordsdb.push line.chomp.downcase.split("")
  end
end

board = []
input = nil
# Actual game starts here:
gamedone = false
until gamedone do
  win = false
  attempts = 6
  word = []
  word.clear
  board.clear
  word = wordsdb[rand(0...wordsdb.length)]

  # Board creation -------------------------------------
  word.each do
    board.push "_"
  end
  #----------------------------
  puts

  puts "Please type in a letter to guess the word:"

  until board == word || attempts == 0#attempts taken do
    guess = gets.chomp

    if guesses.include?(guess)
      puts "You've already guessed that letter, please guess again"
    end

    if guess.length > 1
      puts "Please type just *ONE* character! Are you trying to cheat?"
    end


    i = 0
    word.each do |l|
      if guess == l
        board[i] = guess
      end
      i += 1
    end
    i = 0
    unless guesses.include?(guess) || word.include?(guess) || guess.length > 1
      attempts -= 1
    end

    board.each do |letter|
      print letter
    end
    puts
    puts "You have #{attempts} attempts left!"
    guesses.push(guess)
  end

  if board == word
    puts "You have guessed the word! You shall be proclaimed hero among many!"
  elsif attempts == 0
    puts "You have killed the poor innocent man, hope you can sleep at night!"
    puts "All you had to do was guess the word: #{word.join}"
  end

  puts "Would you like to play again?:y/n"
  replay = gets.chomp
  unless replay.downcase == "y"
    gamedone = true
  end
end
#binding.pry
