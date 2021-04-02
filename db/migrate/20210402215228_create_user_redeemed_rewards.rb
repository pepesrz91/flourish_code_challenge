class CreateUserRedeemedRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :user_redeemed_rewards do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
