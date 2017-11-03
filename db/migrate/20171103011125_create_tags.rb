class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.references :movie
      t.string :key

      t.timestamps
    end
  end
end
