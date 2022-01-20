class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :code, null: false
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.integer :height, null: false
      t.integer :width, null: false
      t.text :content, null: false
      t.boolean :public, null: false, default: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
