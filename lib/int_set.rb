class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    0 <= num && num < @store.length
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets].push(num) unless include?(num)
  end

  def remove(num)
    @store[num % num_buckets].delete(num) if include?(num)
  end

  def include?(num)
    bucket_items = @store[num % num_buckets]
    bucket_items.each do |bucket_item|
      return true if bucket_item == num
    end
    false
  end

  private

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @count += 1
      resize! if @count >= num_buckets
      @store[num % num_buckets].push(num)
    end
  end

  def remove(num)
    @store[num % num_buckets].delete(num) if include?(num)
    @count -= 1 if include?(num)
  end

  def include?(num)
    bucket_items = @store[num % num_buckets]
    bucket_items.each do |bucket_item|
      return true if bucket_item == num
    end
    false
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    @count = 1
    current_set_vals = set_vals
    doubled_buckets = num_buckets * 2
    @store = Array.new(doubled_buckets) { Array.new }
    current_set_vals.each { |val| insert(val) }
  end

  def set_vals
    vals = []
    @store.each do |bucket|
      vals.concat(bucket)
    end
    vals
  end
end
