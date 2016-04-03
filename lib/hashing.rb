class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_val = 0
    self.each_with_index do |val, idx|
      if val.kind_of?(Array)
        val = val.hash
      end
      hash_val += (val.to_s.ord * idx)
    end
    hash_val.hash
  end
end

class String
  def hash
    self.split("").hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
