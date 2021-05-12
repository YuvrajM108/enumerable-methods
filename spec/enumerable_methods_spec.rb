require_relative '../enumerable_methods'

describe Enumerable do
  describe "#my_each" do
    it "prints every element in an array" do
      arr = [1, 2, 3]
      expect(arr.my_each {|x| puts x, "--" }).to eql(arr)
    end
  end

  describe "#my_each_with_index" do
    let (:hash) { Hash.new }
    it "prints every element with the index of the element" do
      expect(%w(cat dog wombat).each_with_index { |item, index|
      hash[item] = index}).to eql(["cat", "dog", "wombat"])
    end
  end

  describe "#my_select" do
    it "prints every element with the index of the element" do
      arr =  [1,2,3,4,5]
      expect(arr.select { |num|  num.even?  }).to eql([2, 4])
    end
  end

  describe "#my_all?" do
    it "prints true if all elements are longer or equal 3" do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it "prints true if all elements are longer or equal 4" do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it "prints true if all element contain /t/" do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it "prints true if all elements are Numeric" do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end

    it "prints true if all elements have value" do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it "prints true if array have no value" do
      expect([].my_all?).to eql(true)
    end
  end
   
  describe "#my_any?" do
    it "prints true if any elements are longer or equal 3" do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
    end

    it "prints true if any elements are longer or equal 4" do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql(true)
    end

    it "prints true if any element contain /d/" do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
    end

    it "prints true if any elements are Integer" do
      expect([1, 2i, 3.14].my_any?(Integer)).to eql(true)
    end

    it "prints true if any elements have value" do
      expect([nil, true, 99].my_any?).to eql(true)
    end

    it "prints false if any array have no value" do
      expect([].my_any?).to eql(false)
    end
  end

  # %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
  # %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false
  # %w{ant bear cat}.none?(/d/)                        #=> true
  # [1, 3.14, 42].none?(Float)                         #=> false
  # [].none?                                           #=> true
  # [nil].none?                                        #=> true
  # [nil, false].none?                                 #=> true
  # [nil, false, true].none?                           #=> false

  describe "#my_none?" do
    it "prints true if no elements have a length of 5" do
      expect(%w{ant bear cat}.my_none? { |word| word.length == 5 }).to eql(true)
    end

    it "prints true if no elements have a length of 4 or greater" do
      expect(%w{ant bear cat}.my_none? { |word| word.length >= 4 }).to eql(false)
    end

    it "prints true if no element contains /d/" do
      expect(%w{ant bear cat}.my_none?(/d/)).to eql(true)
    end

    it "prints true if no elements are Float" do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end

    it "prints true if array has no values" do
      expect([].my_none?).to eql(true)
    end

    it "prints true if no elements have a value" do
      expect([nil].my_none?).to eql(true)
    end

    it "prints true if all elements are nil or false" do
      expect([nil, false].my_none?).to eql(true)
    end

    it "prints true if all elements are nil or false" do
      expect([nil, false, true].my_none?).to eql(false)
    end
  end
end
