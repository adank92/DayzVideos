class VideosController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy, :activate]
  before_action :set_video, only: [:show, :edit, :update, :destroy, :activate]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :admin_user, only: [:activate]


  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.active
                   .category(params[:cat])
                   .date(params[:date])
                   .duration(params[:duration])

    respond_to do |format|
      format.html { render layout: 'videos_sidebar' }
      format.js
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
    @categories = Category.all
  end

  # GET /videos/1/edit
  def edit
    @categories = Category.all
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = current_user.videos.build(video_params)
    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @video }
      else
        @categories = Category.all
        error_block = -> { render :new  }
        format.html &error_block
        format.js &error_block
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params_update)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def activate
    
  end

  private
    def correct_user
      redirect_to root_path unless @video.user == current_user
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:youtube_id, category_ids: [])
    end

    def video_params_update
      params.require(:video).permit(category_ids: [])
    end
end
