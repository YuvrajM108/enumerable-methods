require_relative '../enumerable_methods'

describe Enumerable do
  describe '#my_each' do
    it 'prints every element in an array' do
      arr = [1, 2, 3]
      expect(arr.my_each { |x| puts x, '--' }).to eql(arr)
    end

    it 'return the enumerator if no block given' do
      arr = [1, 2, 3]
      expect(arr.my_each).to be_an Enumerator
    end

    it 'prints every element in an array and not a HASH' do
      arr = [1, 2, 3]
      expect(arr.my_each { |x| puts x, '--' }).not_to be_a Hash
    end
  end

  describe '#my_each_with_index' do
    let(:hash) { {} }
    it 'prints every element with the index of the element' do
      expect(%w[cat dog wombat].my_each_with_index do |item, index|
               hash[item] = index
             end).to eql(%w[cat dog wombat])
    end

    it 'return the enumerator if no block given' do
      expect(%w[cat dog wombat].each_with_index).to be_an Enumerator
    end

    it 'prints every element with the index of the element and not a HASH' do
      expect(%w[cat dog wombat].my_each_with_index do |item, index|
               hash[item] = index
             end).not_to be_a Hash
    end
  end

  describe '#my_select' do
    let(:arr) { [1, 2, 3, 4, 5] }
    it 'prints every element which are even' do
      expect(arr.my_select(&:even?)).to eql([2, 4])
    end

    it 'prints every even element and not odd element' do
      expect(arr.my_select(&:even?)).not_to eql([1, 3, 5])
    end
  end

  describe '#my_all?' do
    it 'prints true if all elements are longer or equal 3' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'prints true if all elements are longer or equal 4' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'prints true if all element contain /t/' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'prints true if all elements are Numeric' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end

    it 'prints true if all elements have value' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'prints true if array have no value' do
      expect([].my_all?).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'prints true if any elements are longer or equal 3' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
    end

    it 'prints true if any elements are longer or equal 4' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql(true)
    end

    it 'prints true if any element contain /d/' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
    end

    it 'prints true if any elements are Integer' do
      expect([1, 2i, 3.14].my_any?(Integer)).to eql(true)
    end

    it 'prints true if any elements have value' do
      expect([nil, true, 99].my_any?).to eql(true)
    end

    it 'prints false if any array have no value' do
      expect([].my_any?).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'prints true if no elements have a length of 5' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eql(true)
    end

    it 'prints true if no elements have a length of 4 or greater' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eql(false)
    end

    it 'prints true if no element contains /d/' do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(true)
    end

    it 'prints true if no elements are Float' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end

    it 'prints true if array has no values' do
      expect([].my_none?).to eql(true)
    end

    it 'prints true if no elements have a value' do
      expect([nil].my_none?).to eql(true)
    end

    it 'prints true if all elements are nil or false' do
      expect([nil, false].my_none?).to eql(true)
    end

    it 'prints true if all elements are nil or false' do
      expect([nil, false, true].my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    let(:arr) { [1, 2, 4, 2] }
    it 'returns the number of elements in arr' do
      expect(arr.my_count).to eql(4)
    end

    it 'returns the number of elements in arr with a value of 2' do
      expect(arr.my_count(2)).to eql(2)
    end

    it 'returns the number of elements divisible by 2' do
      expect(arr.my_count(&:even?)).to eql(3)
    end
  end

  describe '#my_map' do
    it 'returns each element in range squared' do
      expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end
  end

  describe '#my_inject' do
    it 'returns sum of range of values from 5 to 10' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql(45)
    end

    it 'returns product of range of values from 5 to 10' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eql(151_200)
    end

    it 'returns word with length ranging from 5 to 10' do
      expect(%w[cat sheep bear].inject do |memo, word|
               memo.length > word.length ? memo : word
             end).to eql('sheep')
    end

    it 'returns word with length from 5 to 10 and not under or over the specified range' do
      expect(%w[cat sheep bear].inject do |memo, word|
               memo.length > word.length ? memo : word
             end).not_to eql('cat')
    end
  end
end
