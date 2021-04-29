require 'pry'

# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/ModuleLength

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = []
    arr = self if is_a?(Array)
    arr = my_to_a if is_a?(Range) || is_a?(Hash)

    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = []
    arr = self if is_a?(Array)
    arr = my_to_a if is_a?(Range) || is_a?(Hash)

    i = 0
    while i < arr.length
      yield(i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    in_arr = []
    in_arr = self if is_a?(Array)
    in_arr = my_to_a if is_a?(Range) || is_a?(Hash)

    out_arr = []
    in_arr.my_each { |value| out_arr << value if yield(value) }
    out_arr
  end

  def my_all?(pmtr = nil)
    arr = []
    arr = self if is_a?(Array)
    arr = my_to_a if is_a?(Range) || is_a?(Hash)

    if block_given?
      arr.my_each { |value| return false if yield(value) == false || yield(value).nil? }
      return true
    elsif pmtr.nil?
      arr.my_each { |x| return false if nil_or_false?(x) }
    elsif !pmtr.nil?
      arr.my_each { |x| return false unless class_or_regexp?(x, pmtr) }
    else
      arr.my_each { |x| return false unless x == pmtr }
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
      my_each { |x| return true if class_or_regexp?(x, pmtr) }
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
      if (pmtr.is_a? Class) || pmtr.instance_of?(Regexp)
        my_each { |x| return false if class_or_regexp?(x, pmtr) }
        return true
      end
      my_each { |x| return false if x == pmtr }
      return true
    end

    my_any? { |value| return false if yield(value) }
    true
  end

  def my_count(pmtr = nil, &block)
    arr = self
    arr = arr.to_a unless arr.instance_of?(Array)
    if block_given? || pmtr
      return arr.my_select { |x| x == pmtr }.length if pmtr

      arr.my_select(&block).length
    else
      arr.length
    end
  end

  def my_map(proc = nil)
    return to_enum unless block_given? || proc

    arr = []
    if proc
      my_each { |x| arr << proc.call(x) }
    else
      my_each { |x| arr << yield(x) }
    end
    arr
  end

  def my_inject(startval = nil, sym = nil)
    if (!startval.nil? && sym.nil?) && (startval.is_a?(Symbol) || startval.is_a?(String))
      sym = startval
      startval = nil
    end
    if !block_given? && !sym.nil?
      to_a.my_each { |x| startval = startval.nil? ? x : startval.send(sym, x) }
    else
      to_a.my_each { |x| startval = startval.nil? ? x : yield(startval, x) }
    end
    startval
  end
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/ModuleLength

def multiply_els(n_arr)
  n_arr.my_inject(1, '*')
end

def my_to_a()
  conv_arr = []
  conv_arr = to_a if is_a?(Range)
  conv_arr = flatten if is_a?(Hash)
  conv_arr
end

def class_or_regexp?(value, test_value)
  if test_value.is_a? Class
    return true if value.is_a?(test_value)

    false
  end
  if value.is_a?(String)
    return true if test_value.is_a?(String) && test_value == value
    return true if regexp_check?(value, test_value)

    false
  end
  false
end

def regexp_check?(str, reg_val)
  return true if reg_val.is_a?(Regexp) && reg_val.match(str)

  false
end

def nil_or_false?(value)
  return true if value.nil? || value == false

  false
end
