class CreateSeasons < ActiveRecord::Migration[7.2]
  def change
    create_table :seasons do |t|
      t.references :series, null: false, foreign_key: true
      t.string :name
      t.date :release_date

      t.timestamps
    end
  end
end
