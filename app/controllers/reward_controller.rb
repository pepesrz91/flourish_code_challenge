class RewardController < ApplicationController
  before_action :authorized

  def available_rewards
    user_reward_manager = RewardManager.find_by_user_id(@user.id)
    rewards = Reward.where('price < ?', user_reward_manager.points)
    render json: { data: { message: "Available rewards", available_rewards: rewards } }, status: :ok
  end

  def user_redeems
    reward_manager = RewardManager.find_by_user_id(@user.id)
    selected_reward = Reward.find_by(id: reward_params[:reward_id])
    if selected_reward.price <= reward_manager.points
      redeemed_reward = UserRedeemedReward.create(user_id: @user.id, name: selected_reward[:name])
      redeemed_reward.save
      reward_manager.points -= selected_reward.price
      reward_manager.save
    else
      return render json: { data: { message: "Cannot redeem reward, user doesn't have enough points" } },
                    status: :bad_request
    end
    render json: { data: { message: "Reward redeemed!",
                           reward_manager: reward_manager, user_redeemed_reward: selected_reward } }, status: :created
  end

  def reward_params
    params.permit(:reward_id)
  end

end



