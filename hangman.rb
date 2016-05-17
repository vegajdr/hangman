require "pry"

# Split in

wordsdb = []



input = nil

# Split input words into arrays
until input == "quit" do
  input = gets.chomp
  if input.downcase != "quit"
    wordsdb.push(input.split(""))
  end
end


word = wordsdb[rand(0...wordsdb.length)]



























binding.pry
