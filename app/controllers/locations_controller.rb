class LocationsController < ApplicationController
  def index
    render json: Location.all, status: :ok
  end

  def create
    location = Location.find_by(name: params[:name])

    if location.present?
      render json: {message: "Location already exit"}, status: :ok
    else
      location = Location.new(location_params)
      if location.save
        render json: location, status: :created
      else
        render json: location.errors.full_message, status: :unprocessable_entity
      end
    end
  end

  def destroy
    location = Location.find(params[:id])

    if location&.destroy
      render json: {message: "Location deleted successfully"}, status: :ok
    else
      render json: { error: location.errors.full_message }, status: :unprocessable_entity
    end
  end

  private
  def location_params
    params.permit(:name, :latitude, :longitude)
  end
end
