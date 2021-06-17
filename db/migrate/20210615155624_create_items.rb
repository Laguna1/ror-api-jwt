class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.date :day, null: false

      t.timestamps
    end
  end
end
