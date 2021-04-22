class Api::V1::ItemsController < ApplicationController
  def index
    items = RakutenWebService::Ichiba::Item.search(search_params)
  end

  def search_params
    params.permit(:keyword)
  end
end
