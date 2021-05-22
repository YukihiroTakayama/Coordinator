class PartsController < ApplicationController
  impressionist actions: [:show]

  def show
    part = Part.find_by!(token: params[:token])
    impressionist_count = part.impressionist_count(filter: :session_hash)
    impressionist part
    if impressionist_count != part.impressionist_count(filter: :session_hash)
      reward = part.coordinate.user.reward
      reward.amount = reward.amount + part.reward_amount
      reward.save
    end
    redirect_to item_path(part.item_code)
  end
end
