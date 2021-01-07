module Enumerable
  def my_each
    if block_given?
      i = 0
      while i < length
        yield(to_a[i])
        i += 1
      end
    else
      return to_enum
    end
  end

  def my_each_with_index
    i = 0
    while i < length
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
      true
    else
      false
    end
  end

  def my_any?
    array = []
    my_each { |value| array << value if yield value }
    if array.empty?
      false
    else
      true
    end
  end

  def my_none?
    array = []
    my_each { |value| array << value if yield value }
    if array.empty?
      true
    else
      false
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

p %w[a b c d].my_each
