# frozen_string_literal: true

class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :width, null: false, default: 0
      t.integer :height, null: false, default: 0
      t.integer :mines_count, null: false, default: 0
      t.text :mine_positions, array: true, default: []

      t.timestamps
    end
  end
end
