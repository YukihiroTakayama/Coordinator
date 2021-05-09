class PartsController < ApplicationController
  impressionist actions: [:show]

  def show
    part = Part.find_by(token: params[:token])
    impressionist part
    redirect_to item_path(part.code)
  end
end
