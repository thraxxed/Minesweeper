require 'colorize'

class Tile

  attr_accessor :revealed, :flag, :num_touching, :mine

  def initialize()
    @mine = false #BOOLEAN: true --> has a mine at this tile
    @flag = false
    @num_touching = 0
  end

  def place_mine
    @mine = true
  end

  def set_num_touching(num)
    @num_touching = num
  end

  def to_s
    if @revealed
      if @mine
        "!".red
      else
        @num_touching.green
      end
    elsif @flag
      "F".blue
    else
      "?"
    end
  end

  # def to_s
  #   if @mine
  #     "!".red
  #   else
  #     "#{@num_touching}".green
  #   end
  # end

end
