module Enumerable 

  def my_each
    (self.length).times { |index| yield(self[index]) }
  end

  def my_each_with_index
    (self.length).times { |index| yield(self[index], index) }
  end

  def my_select
    return self.to_enum if !(block_given?)
  	my_selection = []
  	self.my_each { |item| my_selection << item if yield(item) }
  	my_selection
  end

  def my_all?(&block)
    if !(block_given?)
      self.my_each { |item| return false if item == false || item == nil }
      return true
    end
    my_selection = self.my_select &block
    return true if self == my_selection  
    false
  end

  def my_none?
    if !(block_given?)
    self.my_each { |item| return false if item}
    return true
  end
    self.my_each { |item| return false if (yield(item)) }
    true
  end

  def my_any?(&block) 
    !(self.my_none? &block)
  end

  def my_count(&block)
    count = 0
    if !(block_given?)
      count = self.length
      return count
    end
    count = self.my_select(&block).length
  end

  def my_map(&proc)
    array = self.to_a
    mapped_array = []
    if !(block_given?)
      mapped_array = array.to_enum
      return mapped_array
    end
    array.my_each { |item| mapped_array << yield(item) }
    mapped_array
  end

  def my_inject(*arguments)
    array = self.to_a
    if arguments.length > 0 && arguments[0].class != Symbol
      accumulator = arguments[0]
      array.my_each { |item| accumulator = yield(accumulator, item) }
    elsif arguments.length == 0
      accumulator = self.to_a[0]
      array[1..-1].my_each { |item| accumulator = yield(accumulator, item) }
    elsif arguments[0].class == Symbol
      accumulator = self.to_a[0]
      operation = arguments[0]
      array[1..-1].my_each { |item| accumulator = accumulator.send(operation, item) }
    end
    accumulator
  end

  def multiply_els(array)
    array.my_inject { |product, n| product * n }
  end

end 

include Enumerable


array1 = ["hi", 43, "potatoes", "horses", 33]

puts "my_each output\:";puts ""
array1.my_each { |item| puts item }

puts "";puts "each output\:";puts ""
array1.each { |item| puts item }

puts "";puts "my_each_with_index_output\:";puts ""
array1.my_each_with_index { |item, index| puts item; puts index }

puts "";puts "each_with_index output\:";puts ""
array1.each_with_index { |item, index| puts item; puts index }

puts "";puts "my_select output\:";puts ""
puts array1.my_select { |item| item.to_s.length > 2 }

puts "";puts "select output\:";puts ""
puts array1.select { |item| item.to_s.length > 2 }

puts "";puts "my_all? output\:";puts ""
puts ["lul","what","potatoes", "uhh"].my_all? {|word| word.length >= 3}
puts ["lul","what","potatoes", "uhh", nil].my_all?

puts "";puts "all? output\:";puts ""
puts ["lul","what","potatoes", "uhh"].all? {|word| word.length >= 3}
puts ["lul","what","potatoes", "uhh", nil].all?

puts "";puts "none? output\:";puts ""
puts %w{ant bear cat}.none? {|word| word.length == 5}  
puts %w{ant bear cat}.none? {|word| word.length >= 4}
puts [].none?                                          
puts [nil].none?                                       
puts [nil,false].none?

puts "";puts "my_none? output\:";puts ""
puts %w{ant bear cat}.my_none? {|word| word.length == 5}  
puts %w{ant bear cat}.my_none? {|word| word.length >= 4}
puts [].my_none?                                          
puts [nil].my_none?                                       
puts [nil,false].my_none?

puts "";puts "any? output\:";puts ""
puts ["ant", "bear", "cat"].any? {|word| word.length >= 3}   
puts ["ant", "bear", "cat"].any? {|word| word.length >= 4}   
puts [ nil, true, 99 ].any?
                                       
puts "";puts "my_any? output\:";puts ""
puts ["ant", "bear", "cat"].my_any? {|word| word.length >= 3}   
puts ["ant", "bear", "cat"].my_any? {|word| word.length >= 4}   
puts [ nil, true, 99 ].my_any?

puts "";puts "count output\:";puts ""
puts ["ant", "bear", "cat"].count   
puts ["ant", "bear", "cat"].count {|word| word.length >= 4}   
puts [1, 2, 4, 2].count { |x| x % 2 == 0 } 


puts "";puts "my_count output\:";puts ""
puts ["ant", "bear", "cat"].my_count   
puts ["ant", "bear", "cat"].my_count {|word| word.length >= 4}   
puts [1, 2, 4, 2].my_count { |x| x % 2 == 0 }

testyproc = Proc.new { |i| i * i } 

puts "";puts "my_map output\:";puts ""
puts (1..4).my_map { |i| i * i }     
puts (1..4).my_map { "cat" }
puts (1..4).my_map(&testyproc)

puts "";puts "map output\:";puts ""
puts (1..4).map { |i| i * i }      
puts (1..4).map { "cat" } 
puts (1..4).map(&testyproc) 

longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end

puts "";puts "inject output\:";puts ""
puts (5..10).inject { |sum, n| sum + n }
puts (5..10).inject(:+)
puts (5..10).inject { |product, n| product * n }
puts longest

longest = %w{ cat sheep bear }.my_inject do |memo, word|
   memo.length > word.length ? memo : word
end

puts "";puts "my_inject output\:";puts ""
puts (5..10).my_inject { |sum, n| sum + n }
puts (5..10).my_inject(:+)
puts (5..10).my_inject { |product, n| product * n }
puts longest

puts "";puts "multiply_els output\:";puts ""
puts multiply_els([2,4,5])
