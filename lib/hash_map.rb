require_relative 'hashing'
require_relative 'linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    num = key.hash
    bucket_items = @store[num % num_buckets]
    bucket_items.each do |bucket_item|
      return true if bucket_item.key == key
    end
    false
  end

  def set(key, val)
    num = key.hash
    if include?(key) && val != get(key)
      bucket_items = @store[num % num_buckets]
      bucket_items.each do |bucket_item|
        bucket_item.val = val if bucket_item.key == key
      end
    else
      @count += 1
      resize! if @count >= num_buckets
      @store[num % num_buckets].insert(key, val)
    end
  end

  def get(key)
    if include?(key)
      num = key.hash
      bucket_items = @store[num % num_buckets]
      bucket_items.each do |bucket_item|
        return bucket_item.val if bucket_item.key == key
      end
      nil
    end
  end

  def delete(key)
    num = key.hash
    @count -= 1 if include?(key)
    @store[num % num_buckets].remove(key) if include?(key)
  end

  def each
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @count = 1
    current_set_vals = set_vals
    doubled_buckets = num_buckets * 2
    @store = Array.new(doubled_buckets) { LinkedList.new }
    current_set_vals.each { |val| set(val[0], val[1]) }
  end

  def set_vals
    vals = []
    @store.each do |bucket|
      bucket.each do |ll_item|
        vals.push([ll_item.key, ll_item.val])
      end
    end
    vals
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
