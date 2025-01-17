class CreateSeries < ActiveRecord::Migration[7.2]
  def change
    create_table :series do |t|
      t.string :name

      t.timestamps
    end
  end
end
