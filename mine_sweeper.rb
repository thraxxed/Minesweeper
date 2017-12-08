require_relative 'board'

class MineSweeper
  attr_accessor :board, :num_flags

  def initialize
    @board = Board.new
    @num_flags = 25
  end

  def get_pos
    puts "enter position"
    gets.chomp.split(",").map { |char| Integer(char) }
  end

  def get_input
    puts "Place a (f)lag or (r)eveal a tile"

    case gets.chomp
    when "f"
      if @num_flags < 1
        puts "out of flags"
        get_input
      end
      @board.set_flag(get_pos)
      @num_flags -= 1
    when "r"
      @board.reveal(get_pos)
    end
  end

  def play
    while true
      @board.render
      get_input
      puts ""
    end
  end

end

MineSweeper.new.play
