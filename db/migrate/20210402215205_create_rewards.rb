class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.string :name
      t.string :price

      t.timestamps
    end
  end
end
