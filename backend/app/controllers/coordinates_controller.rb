class CoordinatesController < ApplicationController
  def index
  end

  def show
    coordinate = Coordinate.find(params[:id])
    render json: coordinate, include: [:parts, :images]
  end

  def update
    coordinate = Coordinate.find(params[:id])
    coordinate.attributes = coordinate_params
    coordinate.parts_attributes = parts_attributes_params
    coordinate.save!
  end

  private

  def coordinate_params
    params.permit(:title, :caption)
  end

  def parts_attributes_params
    params.permit(parts: [:id, :item_code])[:parts]
  end
end
