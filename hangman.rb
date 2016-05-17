require "pry"

# Split in

wordsdb = []
board = []


input = nil

# Split input words into arrays
until input == "quit" do
  input = gets.chomp
  unless input.empty?
    if input.downcase != "quit"
      wordsdb.push(input.split(""))
    end
  end
end

#RANDOM Function
word = wordsdb[rand(0...wordsdb.length)]


word.each do |letter|
  print letter
end

# Board output -------------------------------------
word.each do
  board.push "_"
end

puts

board.each do |letter|
  print letter
end
# ----------------------------------------------------
























binding.pry
