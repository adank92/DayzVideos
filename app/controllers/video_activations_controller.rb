class VideoActivationsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @videos = Video.inactive.paginate(page: params[:page], per_page: 10)
  end

  def edit
    if Video.find(params[:id]).activate
      flash[:success] = "Video activated!"
    else
      flash[:danger] = "Issue while trying to activate video"
    end
    redirect_to video_activations_path
  end
end
