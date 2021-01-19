#spec/enumerables_spec.rb

require_relative "../enumerables.rb"

describe Enumerable do
  !let(:arr) { [1, 2, 3, 4, 5, 6] }
  !let(:hash) { { one: 1, two: 2, three: 3, four: 4 } }

  describe "#my_each" do
    it "returns each element of the array" do
      i = 0
      arr.my_each do |k|
        expect(k).to eql (arr[i])
        i += 1
      end
    end
    it "returns each element of a hash" do
      hash.my_each do |k, j|
        expect(j).to eql (hash[k])
      end
    end
    it "it returns an enumerator if not block is passed in the array" do
      expect(arr.my_each.is_a?(Enumerator)).to be_truthy
    end
    it "it returns an enumerator if not block is passed in the hash" do
      expect(hash.my_each.is_a?(Enumerator)).to be_truthy
    end
  end

  describe "#my_each_with_index" do
    it "returns each element and index of an array" do
      i = 0
      arr.my_each_with_index do |k, index|
        expect(index).to eql(i)
        i += 1
      end
    end
    it "returns an enumerable if block is not given" do
      expect(arr.my_each_with_index.is_a?(Enumerator)).to be_truthy
    end
  end
  describe "#my_select" do
    it "returns an array with elements that return true for the block condition" do
      expect(arr.my_select(&:even?)).to eql ([2, 4, 6])
    end
    it "returns an array with key-value pair for the matching value" do
      expect(hash.my_select { |k, j| j == 1 }).to eql([[:one, 1]])
    end
    it "returns an enumerator of the elements of the array if not block is given" do
      expect(arr.my_select.is_a?(Enumerator)).to be_truthy
    end
    it "returns an enumerator of the elements of the hash if not block is given" do
      expect(hash.my_select.is_a?(Enumerator)).to be_truthy
    end
  end
  describe "#my_all?" do
    it "returns true if all the elements of the array return true" do
      expect(arr.my_all? { |el| el.is_a?(Numeric) }).to be_truthy
    end
    it "returns true if all the elements === pattern in the collection" do
      expect(hash.my_all?(/[ 0-9 ]/)).to be_truthy
    end
    it "returns false if any of the elements is false or nil" do
      expect([1, 3, nil, 4].my_all?).to be_falsy
    end
    it "returns true if none elements is false or nil when block is not given" do
      expect(arr.my_all?).to be_truthy
    end
  end
  describe "#my_any?" do
    it " returns true if at least element of the array returns true to the condition of the block" do
      expect(arr.my_any?(&:even?)).to be_truthy
    end
    it "returns true if any of the element === pattern in the collection" do
      expect(hash.my_any?(/[0-9]/)).to be_truthy
    end
    it "returns false if all of the element are false or nil" do
      expect([1, 2, nil, 4].my_any?).to be_truthy
    end
    it "returns true if at least onw of the conditions is not false or nil when no block is given" do
      expect(arr.my_any?).to be_truthy
    end
  end
end
