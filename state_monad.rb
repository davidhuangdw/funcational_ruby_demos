
class SimpleStateMonad
  def initialize(proc=get.open)
    @proc = proc
  end

  def fmap(&blk)
    res = ->(state) do
      value, state = @proc.call(state)
      [blk.call(value), state]
    end
    create res
  end

  def get
    create ->(state){[state,state]}
  end

  def open
    @proc
  end

  private
  def create(*args)
    self.class.new(*args)
  end
end

