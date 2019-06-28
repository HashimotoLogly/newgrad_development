# frozen_string_literal: true
class CreateRepos < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :ad_id, null: false
      t.integer :adspot_id, null: false
      t.integer :click, null: false, default: 0
      t.integer :imp, null: false, default: 0
      t.integer :cv, null: false, default: 0
      t.integer :price, null: false, default: 0
      t.date :date, null: false, unique: true
      t.timestamps
    end
  end
end
