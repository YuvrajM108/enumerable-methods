module Enumerable
  def my_each
    unless block_given?
        return to_enum(:my_each)
    end
    arr = self
    i = 0
    while i < arr.length
        yield(arr[i])
        i += 1
    end
    self
  end
end
