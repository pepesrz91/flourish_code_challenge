class AddUserToSessionStore < ActiveRecord::Migration[6.1]
  def change
    add_reference :session_stores, :user, null: false, foreign_key: true
  end
end
