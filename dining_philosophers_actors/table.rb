require 'celluloid'

class Table
  include Celluloid
  attr_reader :size

  def initialize(size)
    @size = size
    @forks_taken = (0...size).map{false}
  end

  def hungry(philosopher, pos)
    if forks_free_at(pos)
      obtain_forks_at(pos)
      philosopher.async.eat
    else
      philosopher.async.think
    end
  end

  def done_eat(pos)
    drop_forks_at(pos)
  end

  private

  def forks_free_at(pos)
    !@forks_taken[pos] && !@forks_taken[(pos+1)%size]
  end

  def obtain_forks_at(pos)
    set_forks_at(pos,true)
  end

  def drop_forks_at(pos)
    set_forks_at(pos,false)
  end
  def set_forks_at(pos, value)
    @forks_taken[pos] = value
    @forks_taken[(pos+1)%size] = value
  end
end
