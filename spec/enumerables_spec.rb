# spec/enumerables_spec.rb

require_relative '../enumerables'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5, 6] }
  let(:hash) { { one: 1, two: 2, three: 3, four: 4 } }

  describe '#my_each' do
    it 'returns each element of the array' do
      i = 0
      arr.my_each do |k|
        expect(k).to eql(arr[i])
        i += 1
      end
    end
    it 'returns each element of a hash' do
      hash.my_each do |k, j|
        expect(j).to eql(hash[k])
      end
    end
    it 'it returns an enumerator if not block is passed in the array' do
      expect(arr.my_each.is_a?(Enumerator)).to be_truthy
    end
    it 'it returns an enumerator if not block is passed in the hash' do
      expect(hash.my_each.is_a?(Enumerator)).to be_truthy
    end
  end

  describe '#my_each_with_index' do
    it 'returns each element and index of an array' do
      i = 0
      arr.my_each_with_index do |_k, index|
        expect(index).to eql(i)
        i += 1
      end
    end
    it 'returns an enumerable if block is not given' do
      expect(arr.my_each_with_index.is_a?(Enumerator)).to be_truthy
    end
  end
  describe '#my_select' do
    it 'returns an array with elements that return true for the block condition' do
      expect(arr.my_select(&:even?)).to eql([2, 4, 6])
    end
    it 'returns an array with key-value pair for the matching value' do
      expect(hash.my_select { |_k, j| j == 1 }).to eql([[:one, 1]])
    end
    it 'returns an enumerator of the elements of the array if not block is given' do
      expect(arr.my_select.is_a?(Enumerator)).to be_truthy
    end
    it 'returns an enumerator of the elements of the hash if not block is given' do
      expect(hash.my_select.is_a?(Enumerator)).to be_truthy
    end
  end
  describe '#my_all?' do
    it 'returns true if all the elements of the array return true' do
      expect(arr.my_all? { |el| el.is_a?(Numeric) }).to be_truthy
    end
    it 'returns true if all the elements === pattern in the collection' do
      expect(hash.my_all?(/[ 0-9 ]/)).to be_truthy
    end
    it 'returns false if any of the elements is false or nil' do
      expect([1, 3, nil, 4].my_all?).to be_falsy
    end
    it 'returns true if none elements is false or nil when block is not given' do
      expect(arr.my_all?).to be_truthy
    end
  end
  describe '#my_any?' do
    it ' returns true if at least element of the array returns true to the condition of the block' do
      expect(arr.my_any?(&:even?)).to be_truthy
    end
    it 'returns true if any of the element === pattern in the collection' do
      expect(hash.my_any?(/[0-9]/)).to be_truthy
    end
    it 'returns false if all of the element are false or nil' do
      expect([1, 2, nil, 4].my_any?).to be_truthy
    end
    it 'returns true if at least onw of the conditions is not false or nil when no block is given' do
      expect(arr.my_any?).to be_truthy
    end
  end
  describe '#my_none?' do
    it 'return true if the block never returns true for all elements' do
      expect(arr.my_none? { |el| el == 15 }).to be_truthy
    end
    it 'returns true if any of the element === pattern in the collection' do
      expect(hash.my_none?(/[7-9]/)).to be_truthy
    end
    it 'returns false if any of the element === pattern in the collection' do
      expect(hash.my_none?(/[0-9]/)).to be_falsy
    end
    it 'return true only if none of the collection members is true and there is no block' do
      expect([3, 4, true].my_none?)
    end
  end
  describe '#my_count' do
    it 'returns the count if an argument is passed' do
      expect([1, 1, 1].my_count(1)).to eql(3)
    end
    it 'returns the count if a block is passed matching the condition of the block' do
      expect([2, 2, 4, 4, 6, 6].my_count(&:even?)).to eql(6)
    end
    it 'returns the count if there is no block or argument' do
      expect(arr.my_count).to eql(6)
    end
  end
  describe '#my_map' do
    it 'returns new array with the results of running block once every element in enum' do
      expect((1..4).map { |i| i**2 }).to eql([1, 4, 9, 16])
    end
    it 'returns an enumerator if no block is given' do
      expect((1..4).map.is_a?(Enumerator)).to be_truthy
    end
    it 'returns a new array with the values of every element in the hash' do
      expect(hash.map { |_k, v| v }).to eql([1, 2, 3, 4])
    end
  end
  describe '#my_inject' do
    it 'combines all elements of enum by applying a binary operation' do
      expect((5..10).my_inject(:+)).to eql(45)
    end
    it 'for each element in enum the block is passed an accumulator value and the element' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eql(151_200)
    end
    it 'combines all elements of enum by using a block and inject' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql(45)
    end
  end
  describe '#multiply_els' do
    it 'returns a multiplication on the array' do
      expect(multiply_els(arr)).to eql(720)
    end
  end
end
