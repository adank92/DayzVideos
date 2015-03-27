class CategoriesController < ApplicationController

  def show
    @videos = Category.find_by_name(params[:name]).videos
    render 'videos/index'
  end

end
