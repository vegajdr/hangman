require "pry"
print "Let's play hangman!, a man's life lays on your hands"
# Split in
# 6 guesses
# handle invalid characters
wordsdb = []
d =[]
guesses = []

File.open("/usr/share/dict/words") do |f|
  f.each_line do |line|
    wordsdb.push line.chomp.downcase.split("")
  end
end


board = []
input = nil

#binding.pry

# # Split input words into arrays
# until input == "quit" do
#   input = gets.chomp
#   unless input.empty?
#     if input.downcase != "quit"
#       wordsdb.push(input.split(""))
#     end
#   end
# end

#RANDOM Function
word = wordsdb[rand(0...wordsdb.length)]

#Print word
# word.each do |letter|
#   print letter
# end

# Board creation -------------------------------------
word.each do
  board.push "_"
end
#----------------------------
puts

# Actual game starts here:

win = false
attempts = 6


puts "Please type in a letter to guess the word:"

until board == word || attempts == 0#attempts taken do
  guess = gets.chomp

  if guesses.include?(guess)
    puts "You've already guessed that letter, please guess again"
  end

  if guess.length > 1
    puts "Please type just *ONE* character! Are you trying to cheat?"
  end

  #if guess

  i = 0
  word.each do |l|
    if guess == l
      board[i] = guess
    end
    i += 1
  end
  i = 0
  unless guesses.include?(guess) || guess.length > 1
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

#binding.pry
