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
end
