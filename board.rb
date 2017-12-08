require_relative 'tile'
require 'colorize'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(10) { Array.new(10) { Tile.new } }
    build_grid
    assign_num_touching
  end

  def []=(pos, val)
    x, y = pos
    @grid[y][x] = val
  end

  def [](pos)
    x, y = pos
    @grid[y][x]
  end

  def assign_num_touching
    (0..9).each do |x|
      (0..9).each do |y|
        self[[x,y]].set_num_touching(num_mines_touching( [x,y] ) )
      end
    end
  end

  def build_grid
    positions = (0...100).to_a.shuffle
    25.times do
      pos = positions.shift
      x = pos % 10
      y = pos / 10
      self[[x, y]].place_mine
    end
  end

  def set_flag(pos)
    self[pos].flag = true
  end

  def reveal(pos)
    self[pos].revealed = true
    if self[pos].mine
      puts "Game over!"
      exit!
    end
  end

  def num_mines_touching(pos)
    x, y = pos
    possible_xs = [x]
    possible_ys = [y]

    case x
    when 0
      possible_xs << x + 1
    when 9
      possible_xs << x - 1
    else
      possible_xs << x - 1 << x + 1
    end

    case y
    when 0
      possible_ys << y + 1
    when 9
      possible_ys << y - 1
    else
      possible_ys << y - 1 << y + 1
    end

    mine_counter = 0

    possible_xs.each do |i|
      possible_ys.each do |j|
        next if i == x && j == y
        mine_counter += 1 if self[[i, j]].mine
      end
    end

    mine_counter.to_s
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        print tile.to_s + " "
      end
      puts ""
    end
    true
  end
end
