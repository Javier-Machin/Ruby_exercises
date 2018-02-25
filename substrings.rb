def substrings(word, dictionary)
  word = word.downcase.split(" ") 
  word_counter = Hash.new(0)
  dictionary.each {|dictionary_word| word.each {|words_input|word_counter[dictionary_word] += 1 if words_input.include?(dictionary_word)}}
  puts word_counter
end

substrings("Howdy partner, sit down! How's it going?", ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"])