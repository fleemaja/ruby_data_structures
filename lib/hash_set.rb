require_relative 'hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    unless include?(key)
      @count += 1
      resize! if @count >= num_buckets
      @store[num % num_buckets].push(key)
    end
  end

  def include?(key)
    num = key.hash
    bucket_items = @store[num % num_buckets]
    bucket_items.each do |bucket_item|
      return true if bucket_item == key
    end
    false
  end

  def remove(key)
    num = key.hash
    @store[num % num_buckets].delete(key) if include?(key)
    @count -= 1 if include?(key)
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
