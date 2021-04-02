class CreateRedeemedRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :redeemed_rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
