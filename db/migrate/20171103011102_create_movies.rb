class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.references :actress
      t.string :title
      t.integer :year
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
