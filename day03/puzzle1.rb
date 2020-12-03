#!/usr/bin/env ruby

forest = File.open('input.txt').readlines.map(&:chomp)

# Sample the forest, see how big each glen is. Subtract one as we're using this as a string index, which counts from 0
idx_width = forest[0].length - 1

# our starting position on the first line (glen)
x = 0
y = 0

collisions = 0

forest.each do |glen|

  x += 3
  y += 1 # always the next line

  # y counts from 0, length counts from 1
  if y > forest.length-1
    # No more lines if we're here
    break
  end

  if x > idx_width
    # x has gone beyond the end of the line
    # again, since we're counting from zero, subtract 1 from the difference between x and the index width
    x = (x - idx_width) - 1
  end

  if forest[y][x] == '#'
    collisions += 1
  end

end

puts("%d collisions" % collisions)

