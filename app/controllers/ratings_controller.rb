class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in'
    else
      @rating.user_id = current_user.id
      if @rating.save
        current_user.ratings << @rating
        redirect_to user_path current_user
      else
        redirect_to beers_path
      end
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end