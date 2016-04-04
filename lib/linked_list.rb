class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @end = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @end
  end

  def empty?
    @head.nil?
  end

  def get(key)
    current = @head
    while !current.nil?
      return current.val if current.key.to_s == key.to_s
      current = current.next
    end
    nil
  end

  def include?(key)
    get(key) ? true : false
  end

  def insert(key, val)
    if !include?(key)
      new_link = Link.new(key, val)
      if @head.nil?
        @head = new_link
        @end = new_link
      else
        tmp = @end
        @end.next = new_link
        new_link.prev = tmp
        @end = new_link
      end
    end
  end

  def remove(key)
    prev_link = nil
    current = @head
    while !current.nil?
      if current.key == key
        next_link = current.next
        if !prev_link.nil?
          prev_link.next = next_link
        else
          @head = next_link
        end
        if !next_link.nil?
          next_link.prev = prev_link
        else
          @end = next_link
        end
        break
      end
      prev_link = current
      current = current.next
    end
  end

  def each
    current = @head
    while !current.nil?
      yield current
      current = current.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
