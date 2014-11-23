
class MaybeMonad
  def initialize(*args)
    raise "Please use MaybeMonad.create(value)"
  end
  def open; @value end
end

class Just < MaybeMonad
  def initialize(value)
    raise "couldn't be nil" if value.nil?
    @value = value
  end
  def fmap(&blk)
    create blk.call(@value)
  end
end

class Nothing < MaybeMonad
  def initialize; end
  def fmap(&blk); self end
end


class MaybeMonad
  def self.create(value)
    value.nil? ? Nothing.new : Just.new(value)
  end
  def create(value)
    MaybeMonad.create(value)
  end
end