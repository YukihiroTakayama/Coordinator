class GenresController < ApplicationController
  def index
    render json: genres
  end

  private

  def genres
    RakutenWebService::Ichiba::Genre.root.children.to_a.map do |genre|
      { id: genre.id, name: genre.name }
    end
  end
end
