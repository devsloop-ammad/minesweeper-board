# frozen_string_literal: true

class BoardsController < ApplicationController
  def index
    @boards = Board.all.order(created_at: :desc)
  end

  def new
    @board = Board.new
    @boards = Board.all.order(created_at: :desc).limit(10)
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      @board.set_mines
      redirect_to board_path(@board.id)
    else
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @grid = Minesweeper.new(@board).render
  end

  private

  def board_params
    params.require(:board).permit(:email, :name, :height, :width, :mines_count)
  end
end
