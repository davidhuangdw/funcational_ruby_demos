require_relative 'philosopher'
require_relative 'table'

n = 5
table = Table.new(n)
philosophers = (0...n).map do |i|
  Philosopher.new("Philosopher #{i}")
end

philosophers.each_with_index {|p,i| p.dine(table,i)}

sleep