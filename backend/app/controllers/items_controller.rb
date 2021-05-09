class ItemsController < ApplicationController
  def index
    items = fetch_items
    render json: items
  end

  def show
    item = Rails.cache.fetch("/api/v1/items/#{params[:code]}", expired_in: 1.hour) do
      RakutenWebService::Ichiba::Item.search(item_code: params[:code]).first
    end
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
