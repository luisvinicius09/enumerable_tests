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
    array = []
    my_each { |value| array << value if yield value }
    print arr
  end

  def my_all?
    array = []
    my_each { |value| array << value unless yield value }
    if array.empty?
      return true
    else
      return false
    end
  end

  def my_any?
    array = []
    my_each { |value| array << value if yield value }
    if array.empty?
      return false
    else
      return true
    end
  end

  def my_none?
    array = []
    my_each { |value| array << value if yield value }
    if array.empty?
      return true
    else
      return false
    end
  end

  def my_count
    count = 0
    my_each { |value| count += 1 if yield value }
    count
  end

  def my_map(proc = nil)
    array = []
    if proc.nil?
      my_each do |value|
        value = yield value
        array << value
      end
    else
      my_each do |value|
        value = proc.call(value)
        array << value
      end
    end
    array
  end

  def my_inject(result = 0)
    my_each { |value| result = yield(result, value) }
    result
  end

  def multiply_els(result = 1)
    my_each { |value| result = yield(result, value) }
    result
  end
end

my_proc = Proc.new { |n| n.upcase }
p ["a", "b", "c"].my_map(my_proc)
