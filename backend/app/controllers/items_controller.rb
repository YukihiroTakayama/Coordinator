class ItemsController < ApplicationController
  def index
    items = fetch_items
    render json: items
  end

  def show
    item = RakutenWebService::Ichiba::Item.search(item_code: params[:code]).first
    render json: item
  end

  def fetch_items
    RakutenWebService::Ichiba::Item.search(search_params)
  end

  def search_params
    allow_params = [:genre_id]
    allow_params.push(:keyword) if params[:keyword] && params[:keyword].length >= 2
    params.permit(allow_params)
  end
end
