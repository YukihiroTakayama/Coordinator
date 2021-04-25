class ItemsController < ApplicationController
  def index
    items = RakutenWebService::Ichiba::Item.search(search_params)
    render json: items
  end

  def search_params
    params.permit(:keyword)
  end
end
