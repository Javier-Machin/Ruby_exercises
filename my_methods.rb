module Enumerable 

  def my_each
    (self.length).times { |index| yield(self[index]) }
  end

  def my_each_with_index
    (self.length).times { |index| yield(self[index], index) }
  end

  def my_select
  	my_selection = []
  	(self.length).times { |index| my_selection << self[index] if (yield(self[index])) }
  	my_selection
  end

  def my_all?
  	if !(block_given?)
  	  self.length.times { |index| return false if self[index] == false || self[index] == nil }
  	  return true
  	end
    my_selection = []
  	(self.length).times { |index| my_selection << self[index] if (yield(self[index])) }
  	return true if self == my_selection  
  	return false
  end

  def my_any?
  	if !(block_given?)
  	  self.length.times { |index| return true if (self[index]) }
  	  return false
  	end
  	self.length.times { |index| return true if (yield(self[index])) }
  	return false
  end	
 
  def my_none?
  	if !(block_given?)
  	  self.length.times { |index| return false if (self[index]) }
  	  return true
  	end
  	self.length.times { |index| return false if (yield(self[index])) }
  	return true
  end

  #def my_count	
end 

array1 = ["hi", 43, "potatoes", "poopy", 33]

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

puts "";puts "all? output\:";puts ""
puts ["lul","what","potatoes", "uhh"].all? {|word| word.length >= 3}

puts "";puts "my_any? output\:";puts ""
puts ["ant", "bear", "cat"].my_any? {|word| word.length >= 3}   
puts ["ant", "bear", "cat"].my_any? {|word| word.length >= 4}   
puts [ nil, true, 99 ].my_any?

puts "";puts "any? output\:";puts ""
puts ["ant", "bear", "cat"].any? {|word| word.length >= 3}   
puts ["ant", "bear", "cat"].any? {|word| word.length >= 4}   
puts [ nil, true, 99 ].my_any?

puts "";puts "my_none? output\:";puts ""
puts %w{ant bear cat}.my_none? {|word| word.length == 5}  
puts %w{ant bear cat}.my_none? {|word| word.length >= 4}
puts [].my_none?                                          
puts [nil].my_none?                                       
puts [nil,false].my_none?

puts "";puts "none? output\:";puts ""
puts %w{ant bear cat}.none? {|word| word.length == 5}  
puts %w{ant bear cat}.none? {|word| word.length >= 4}
puts [].none?                                          
puts [nil].none?                                       
puts [nil,false].none?