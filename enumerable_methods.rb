require 'pry'

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
      my_each { |x| return false if nil_or_false?(x) }
    elsif !pmtr.nil?
      my_each { |x| return false unless class_or_regexp(x, pmtr) }
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
    elsif !pmtr.nil?
      my_each { |x| return true if class_or_regexp(x, pmtr) }
    else
      my_each { |x| return true if x == pmtr }
    end
    false
  end

  def my_none?(pmtr = nil)
    if !block_given? && pmtr.nil?
      my_each { |x| return false if x }
      return true
    end

    if !block_given? && !pmtr.nil?
      if pmtr.is_a? Class
        my_each { |x| return false if x.instance_of?(pmtr) }
        return true
      end
      if pmtr.instance_of?(Regexp)
        my_each { |x| return false if pmtr.match(x) }
        return true
      end
      my_each { |x| return false if x == pmtr }
      return true
    end

    my_any? { |value| return false if yield(value) }
    true
  end
end

def class_or_regexp?(value, test_value)
  if test_value.is_a? Class
    return true if value.instance_of?(test_value)

    false
  end
  if test_value.instance_of?(Regexp)
    return true if test_value.match(value)

    false
  end
  false
end

def nil_or_false?(value)
  return true if value.nil? || value == false

  false
end
