class User < ApplicationRecord
  belongs_to :reward_manager
  belongs_to :bank
end
