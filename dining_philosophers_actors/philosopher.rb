require 'celluloid'

class Philosopher
  include Celluloid
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def dine(table, pos)
    @table = table
    @pos = pos
    think
  end

  def think
    puts "#{name} is thinking"
    sleep rand
    puts "#{name} get hungry"
    @table.async.hungry(Actor.current, @pos)        # use 'Actor.current', instead of 'self' which is dynamic
  end

  def eat
    puts "#{name} is eating"
    sleep rand
    puts "#{name} finish eating"
    @table.async.done_eat(@pos)
  end

end