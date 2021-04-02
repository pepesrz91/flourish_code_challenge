class CreateRewardManagers < ActiveRecord::Migration[6.1]
  def change
    create_table :reward_managers do |t|
      t.integer :points
      t.integer :login_streak

      t.timestamps
    end
  end
end
