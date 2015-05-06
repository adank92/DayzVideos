require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  setup do
    @youtube_id = 'HJpaqOFjJME'
    @user = users(:one)
    @video = videos(:one)
    @category = categories(:roleplay)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should get new" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

  test "should create video" do
    log_in_as(@user)
    assert_difference('Video.count') do
      post :create, video: { youtube_id: @youtube_id, category_ids: [@category.id] }
    end
    assert_redirected_to video_path(assigns(:video))
  end

  test "should show video" do
    get :show, id: @video
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get :edit, id: @video
    assert_response :success
  end

  test "should update video" do
    log_in_as(@user)
    patch :update, id: @video, video: { youtube_id: @video.youtube_id, category_ids: [@category.id] }
    assert_redirected_to video_path(assigns(:video))
  end

  test "should destroy video" do
    log_in_as(@user)
    assert_difference('Video.count', -1) do
      delete :destroy, id: @video
    end

    assert_redirected_to videos_path
  end
end
