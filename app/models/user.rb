class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  belongs_to :reward_manager
  belongs_to :bank
end
