letters = {}
vowel = ["a", "e", "i", "o", "u", "y"]
alphabet = ("a".."z")

alphabet.each.with_index(1) do |letter, index|
  letters[letter] = index if vowel.include?(letter)
end
