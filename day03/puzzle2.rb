#!/usr/bin/env ruby

forest = File.open('input.txt').readlines.map(&:chomp)
steps = [
    [1,1],
    [3,1],
    [5,1],
    [7,1],
    [1,2]
]

def calc_path(forest, x_step, y_step)

  # Sample the forest, see how big each glen is. Subtract one as we're using this as a string index, which counts from 0
  idx_width = forest[0].length - 1
  idx_length = forest.length - 1

  # our starting position on the first line
  x = 0
  y = 0
  collisions = 0

  while y <= idx_length

    x += x_step
    y += y_step

    # y counts from 0, length counts from 1
    if y > idx_length
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
  collisions
end

total_collisions = []
steps.each do |x_step,y_step|
  collisions = calc_path(forest, x_step, y_step)
  puts("[%d,%d] - %d collisions" % [x_step, y_step, collisions])
  total_collisions << collisions
end

puts("Total: %d" % total_collisions.reject(&:zero?).inject(:*))



