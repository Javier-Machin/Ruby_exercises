array1 = [4,3,78,2,0,2]

def bubble_sort(items)
  (items.length-2).times do
    (items.length-1).times do |index|
      if (items[index] <=> items[index+1]) == 1
        items[index], items[index+1] = items[index+1], items[index]
      end
    end
  end
  items
end

puts array_sorted = bubble_sort(array1)

def bubble_sort_by(items)
  (items.length-2).times do
    (items.length-1).times do |index|
      if yield(items[index], items[index+1]) > 0
        items[index], items[index+1] = items[index+1], items[index]
      end
    end
  end
  items
end

array2 = bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end

puts array2.to_s