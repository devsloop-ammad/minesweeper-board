# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:board) { create(:board) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(board).to be_valid
    end

    it 'is invalid without a name' do
      board.name = nil
      expect(board).to be_invalid
      expect(board.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      board.email = nil
      expect(board).to be_invalid
      expect(board.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with an invalid email' do
      board.email = 'invalid_email'
      expect(board).to be_invalid
      expect(board.errors[:email]).to include('is invalid')
    end

    it 'is invalid without a height' do
      board.height = nil
      expect(board).to be_invalid
      expect(board.errors[:height]).to include("can't be blank")
    end

    it 'is invalid if height is less than equal to 0' do
      board.height = -1
      expect(board).to be_invalid
      expect(board.errors[:height]).to include('must be greater than 0')
    end

    it 'is invalid without a width' do
      board.width = nil
      expect(board).to be_invalid
      expect(board.errors[:width]).to include("can't be blank")
    end

    it 'is invalid if width is less than equal to 0' do
      board.width = -1
      expect(board).to be_invalid
      expect(board.errors[:width]).to include('must be greater than 0')
    end

    it 'is invalid without a mines_count' do
      board.mines_count = nil
      expect(board).to be_invalid
      expect(board.errors[:mines_count]).to include("can't be blank")
    end

    it 'is invalid if mines count is less than equal to 0' do
      board.mines_count = -1
      expect(board).to be_invalid
      expect(board.errors[:mines_count]).to include('must be greater than 0')
    end

    it 'is invalid with a non-integer height' do
      board.height = 5.5
      expect(board).to be_invalid
      expect(board.errors[:height]).to include('must be an integer')
    end

    it 'is invalid with a non-integer width' do
      board.width = 5.5
      expect(board).to be_invalid
      expect(board.errors[:width]).to include('must be an integer')
    end

    it 'is invalid with a non-integer mines_count' do
      board.mines_count = 5.5
      expect(board).to be_invalid
      expect(board.errors[:mines_count]).to include('must be an integer')
    end

    it 'is invalid when mines_count is greater than the total number of cells' do
      board.height = 5
      board.width = 5
      board.mines_count = 30
      expect(board).to be_invalid
      expect(board.errors[:mines_count]).to include('must be less than the total number of cells')
    end
  end
end
