class RewardController < ApplicationController
  before_action :authorized

  def available_rewards
    user_reward_manager = RewardManager.find_by_user_id(@user.id)
    rewards = Reward.where('price < ?', user_reward_manager.points)
    render json: {data: {message:"Available rewards"}, available_rewards:rewards}, status: :ok
  end
end



