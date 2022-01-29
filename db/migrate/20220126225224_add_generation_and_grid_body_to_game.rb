class AddGenerationAndGridBodyToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :generation, :integer, null: false, default: 1
    add_column :games, :grid_body, :json, null: false
    remove_column :games, :content, :text, null: false
  end
end
