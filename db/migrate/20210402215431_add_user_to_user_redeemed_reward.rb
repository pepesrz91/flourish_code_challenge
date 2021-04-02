class AddUserToUserRedeemedReward < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_redeemed_rewards, :user, null: false, foreign_key: true
  end
end
