# frozen_string_literal: true

class Board < ApplicationRecord
  validates :name, :email, :height, :width, :mines_count, presence: true
  validates :height, :width, :mines_count, numericality: { only_integer: true, greater_than: 0 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validate :cell_to_mine_ratio

  before_create :drop_mines

  def drop_mines
    self.mine_positions = (0...height * width).to_a.sample(mines_count)
  end

  private

  def cell_to_mine_ratio
    return if height.blank? || width.blank? || mines_count.blank?
    return if height * width >= mines_count

    errors.add(:mines_count, 'must be less than the total number of cells')
  end
end
