class AddRewardManagerToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :reward_manager, null: false, foreign_key: true
  end
end
