require_relative '../enumerable_methods'

describe Enumerable do
  describe "#my_each" do
    it "prints every element in an array" do
      arr = [1, 2, 3]
      expect(arr.my_each {|x| puts x, "--" }).to eql(arr)
    end
  end
end
