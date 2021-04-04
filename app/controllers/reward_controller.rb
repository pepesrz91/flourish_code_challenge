class RewardController < ApplicationController
  before_action :authorized

  def available_rewards

    user_reward_manager = RewardManager.find_by_user_id(@user.id)
    puts "User points", user_reward_manager
    rewards = Reward.where('price > ?', 200)

    render json: {data: {message:"Available rewards"}, available_rewards:rewards}, status: :ok
  end
end



