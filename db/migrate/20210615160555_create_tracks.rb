class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :duration, null: false
      t.integer :distance, null: false
      t.integer :repeat, null: false
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
