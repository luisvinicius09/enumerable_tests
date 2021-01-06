module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
  end
def my_select
  arr = []
  my_each { |value| arr << value if yield value}
 print arr
end
def my_all?
  array = []
  my_each { |value| array << value unless yield value}
  if array.empty?
    return true
  else
    return false
  end
end
def my_any?
  array = []
  my_each { |value| array << value if yield value}
  if array.empty?
    return false
  else
    return true
  end
end
def my_none?
  array = []
  my_each { |value| array << value if yield value}
  if array.empty?
    return true
  else
    return false
  end
end
def my_count
  count = 0
  my_each { |value| count +=1 if yield value}
  count
end
end

puts [ 2, 4, 7, 10, 6, 12].my_count { |n| n % 2 == 0 } 
