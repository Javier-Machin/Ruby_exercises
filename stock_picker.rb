def stock_picker(array)
  lowest_price = 999
  highest_price = 0
  diffs = []
  lowest_prices = []
  highest_prices = []
  
  #Gives lowest_prices and highest_prices arrays initial values to be used as comparison
  array.each do |stock|
    lowest_price = stock if stock < lowest_price 		
  end

  lowest_prices << lowest_price
  lowest_price = 999

  array.each do |stock|
    highest_price = stock if stock > highest_price && array.index(stock) > array.index(lowest_prices[-1])
  end

  highest_prices << highest_price
  highest_price = 0

  #Keeps adding stock values to both arrays where the highest_prices index in the stocks array is higher than the lowest_prices counterpart
  #Stops when there is no more possible selling or buying days
  until lowest_prices.include?(999)
    array.each do |stock|
  	  lowest_price = stock if stock < lowest_price && (lowest_prices.include?(stock) == false)
    end
    break if lowest_price == 999
    lowest_prices << lowest_price
    lowest_price = 999
    
    array.each do |stock|
      highest_price = stock if stock > highest_price && array.index(stock) > array.index(lowest_prices[-1]) && (highest_prices.include?(stock) == false)
    end
    break if highest_price == 0
    highest_prices << highest_price
    highest_price = 0 
  end
  #Checks what pair of low price day and high price day gives the most benefits
  biggest_diff = 0
  result_message = ""

  lowest_prices.each do |low|
    highest_prices_pair = highest_prices[lowest_prices.index(low)]

  	if highest_prices_pair != nil && highest_prices_pair > low
  	  result_message = "The best day to buy is #{array.index(low)} and the best day to sell is #{array.index(highest_prices_pair)}" if highest_prices_pair - low > biggest_diff
  	  biggest_diff = highest_prices_pair - low if highest_prices_pair - low > biggest_diff	  
  	end
  end

  puts result_message
end

stock_picker([17,3,6,9,15,8,6,1,10])