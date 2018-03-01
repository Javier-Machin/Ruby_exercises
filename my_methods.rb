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

end 

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

