class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      # t.references :reward_manager, null: false, foreign_key: true
      # t.references :bank, null: false, foreign_key: true

      t.timestamps
    end
  end
end
