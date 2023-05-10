# frozen_string_literal: true

class Minesweeper
  def initialize(board)
    @board = board
  end

  def render
    @grid = Array.new(@board.height) { Array.new(@board.width, 0) }

    @board.result&.each do |pos|
      row = pos / @board.width
      col = pos % @board.width
      @grid[row][col] = 1
    end

    @grid
  end
end
