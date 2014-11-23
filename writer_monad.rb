class LogWriterMonad
  def initialize(value, logs=[])
    @value = value
    @logs = logs
  end

  def fmap(&blk)
    nval = blk.call(value)
    nlogs = logs + [log_for(blk)]
    create(nval,nlogs)
  end

  def open
    [@value, @logs]
  end

  private
  attr_accessor :value, :logs

  def create(*args)
    self.class.new(*args)
  end

  def log_for(blk)
    "Invoke #{blk} with #{value}"
  end
end
