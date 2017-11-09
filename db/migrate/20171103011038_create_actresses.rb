class CreateActresses < ActiveRecord::Migration[5.1]
  def change
    create_table :actresses do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
