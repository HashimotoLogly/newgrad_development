# frozen_string_literal: true
class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.integer :advertiser_id, null: false # 広告主ID
      t.string :image, null: false, default: '' # 広告の画像URL
      t.integer :price, null: false # 広告の価格
      t.string :text, null: false, default: '' # 広告の説明文

      t.timestamps
    end
  end
end
