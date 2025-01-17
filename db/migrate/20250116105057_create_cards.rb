class CreateCards < ActiveRecord::Migration[7.2]
  def change
    create_table :cards do |t|
      t.references :season, null: false, foreign_key: true
      t.string :name
      t.string :rarity
      t.string :card_type
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
