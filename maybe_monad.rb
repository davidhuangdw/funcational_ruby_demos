
class MaybeMonad
  def initialize(*args)
    raise "Please use Maybe(value)"
  end
  def open; @value end
  def try(&blk)
    fmap(&blk)
  end
  def create(value)
    Maybe(value)
  end

  include Comparable
  def <=>(other)
    @value <=> value
  end
  protected
  attr_reader :value
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


def Maybe(value)
  value.nil? ? Nothing.new : Just.new(value)
end

