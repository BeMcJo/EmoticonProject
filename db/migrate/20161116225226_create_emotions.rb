class CreateEmotions < ActiveRecord::Migration
  def change
    create_table :emotions do |t|
      t.integer :feeling

      t.timestamps null: false
    end
  end
end
