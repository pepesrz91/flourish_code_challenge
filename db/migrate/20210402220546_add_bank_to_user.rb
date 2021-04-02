class AddBankToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :bank, null: false, foreign_key: true
  end
end
