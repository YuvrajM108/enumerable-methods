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

  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each { |value| arr << value if yield(element) }
    arr
  end

  def my_all?(pmtr = nil)
    if block_given?
      my_each { |value| return false if yield(value) == false }
      return true
    elsif pmtr.nil?
      my_each { |x| return false if x.nil? || x == false }
    elsif !pmtr.nil? && (pmtr.is_a? Class)
      my_each { |x| return false if x.instance_of(pmtr) }
    elsif !pmtr.nil? && pmtr.instance_of?(Regexp)
      my_each { |x| return false unless pmtr.match(x) }
    else
      my_each { |x| return false if x == pmtr }
    end
    true
  end

  def my_any?(pmtr = nil)
    if block_given?
      my_each { |value| return true if yield(value) }
      false
    elsif pmtr.nil?
      my_each { |x| return true if x }
    elsif !pmtr.nil? && (pmtr.is_a? Class)
      my_each { |x| return true if x.instance_of(pmtr) }
    elsif !pmtr.nil? && pmtr.instance_of?(Regexp)
      my_each { |x| return true if pmtr.match(x) }
    else
      my_each { |x| return true if x == pmtr }
    end
    false
  end
end
