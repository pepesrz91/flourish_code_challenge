class AddUserToRewardManager < ActiveRecord::Migration[6.1]
  def change
    add_reference :reward_managers, :user, null: false, foreign_key: true
  end
end
