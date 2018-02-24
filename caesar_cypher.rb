def caesar_cypher(string, shift)
	string = string.split("").map do |char|
	  if (97..122).include?(char.ord) 
		if (char.ord + shift) > 122
		  shifts_over_limit = shift - (122 - char.ord)
		  shifts_over_limit = (shifts_over_limit % 26) if shifts_over_limit >= 26
		  char = (96 + shifts_over_limit).chr
		elsif (char.ord + shift) < 97
		  shifts_under_limit = 97 - (char.ord + shift)
		  shifts_under_limit = (shifts_under_limit % 26) if shifts_under_limit >= 26
		  char = (123 - shifts_under_limit).chr
		else
		  char = (char.ord + shift).chr
		end
	  elsif (65..90).include?(char.ord)
	    if (char.ord + shift) > 90
		  shifts_over_limit = shift - (90 - char.ord)
		  shifts_over_limit = (shifts_over_limit % 26) if shifts_over_limit >= 26
		  char = (64 + shifts_over_limit).chr
		elsif (char.ord + shift) < 65
		  shifts_under_limit = 65 - (char.ord + shift)
		  shifts_under_limit = (shifts_under_limit % 26) if shifts_under_limit >= 26
		  char = (91 - shifts_under_limit).chr
		else
		  char = (char.ord + shift).chr
		end
	  else
	    char = char		
	  end
	end
	string = string.join("")
	puts string
end

caesar_cypher("What a string!", 5)
