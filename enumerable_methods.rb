module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = self
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = self
    i = 0
    while i < arr.length
      yield(i)
      i += 1
    end
    self
  end
end
