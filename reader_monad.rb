class SimpleReaderMonad
  def initialize(proc=ask.open)
    @proc = proc
  end

  def fmap(&blk)
    res = ->(state)do
      blk.call @proc.call(state)
    end
    create res
  end

  def ask
    create ->(state){state}
  end

  def open
    @proc
  end

  private
  def create(*args)
    self.class.new(*args)
  end
end