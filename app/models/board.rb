# frozen_string_literal: true

class Board < ApplicationRecord
  require 'json'

  validates :name, :email, :height, :width, :mines_count, presence: true
  validates :height, :width, :mines_count, numericality: { only_integer: true, greater_than: 0 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validate :cell_to_mine_ratio

  def result
    JSON.parse(self[:result]) if self[:result]
  end

  def set_mines
    update(result: (0...height * width).to_a.sample(mines_count))
  end

  private

  def cell_to_mine_ratio
    return if height * width >= mines_count

    errors.add(:mines_count, 'must be less than the total number of cells')
  end
end
