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
end

[1, 2, 3, 4, 5, 6].my_select { |n| n.even? }
