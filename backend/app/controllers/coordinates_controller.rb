class CoordinatesController < ApplicationController
  # before_action :authenticate_user!

  def index
    coordinates = Coordinate.all || current_user.coordinates
    render json: coordinates, include: [:parts]
  end

  def edit
    coordinate = Coordinate.find(params[:id])
    render json: coordinate, include: [:parts]
  end

  def show
    coordinate = Coordinate.find_by(token: params[:token])
    impressionist coordinate
    render json: coordinate, include: [:parts], meta: { session_hash: session_hash }
  end

  def update
    coordinate = Coordinate.find(params[:id])
    coordinate.attributes = coordinate_params
    coordinate.parts_attributes = parts_attributes_params
    coordinate.save!
    if params[:blob_ids].present?
      coordinate.images.purge
      blobs = ActiveStorage::Blob.find(params[:blob_ids])
      coordinate.images.attach(blobs)
    end
    render status: :ok
  end

  def destroy
    coordinate = Coordinate.find(params[:id])
    coordinate.update!(is_deleted: true)
    render status: :ok
  end

  private

  def coordinate_params
    params.permit(:title, :caption, :sort, :is_deleted)
  end

  def parts_attributes_params
    params.permit(parts: [:id, :item_code, :is_deleted, :sort])[:parts]
  end
end
