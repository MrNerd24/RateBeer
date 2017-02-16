class PlacesController < ApplicationController


  def index
    if params[:city].nil? || params[:city] == ""
      render :index
    else
      @places = BeermappingApi.places_in(params[:city])
      if @places.empty?
        redirect_to places_path, notice: "No locations in #{params[:city]}"
      else
        render :index
      end
    end
  end

  def show
    @place = BeermappingApi.places_in(params[:city]).find { |b| b.name == params[:name] }
    if @place.nil?
      redirect_to places_path
    end
  end


  def search
    redirect_to city_places_path(params[:city])

    # if @places.empty?
    #   redirect_to places_path, notice: "No locations in #{params[:city]}"
    # else
    #   render :index
    # end
  end


end