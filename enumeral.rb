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
    my_each { |value| arr.push(value) if yield(value) }
    arr
  end
end

p [1, 2, 3, 4, 5, 6].my_select { |n| n.even? }
