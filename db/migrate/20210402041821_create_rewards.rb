class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.references :bank, null: false, foreign_key: true
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
