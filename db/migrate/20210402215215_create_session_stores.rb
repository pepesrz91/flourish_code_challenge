class CreateSessionStores < ActiveRecord::Migration[6.1]
  def change
    create_table :session_stores do |t|
      t.timestamp :last_login

      t.timestamps
    end
  end
end
