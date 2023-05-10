# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Minesweeper do
  describe '#render' do
    let(:board) { double('board', width: 3, height: 3, result: [0, 4, 8]) }
    let(:minesweeper) { Minesweeper.new(board) }

    it 'renders the board with the correct dimensions' do
      expect(minesweeper.render.length).to eq(3)
      expect(minesweeper.render.first.length).to eq(3)
    end

    it 'marks the cells with mines as 1' do
      expect(minesweeper.render[0][0]).to eq(1)
      expect(minesweeper.render[1][1]).to eq(1)
      expect(minesweeper.render[2][2]).to eq(1)
    end
  end
end
