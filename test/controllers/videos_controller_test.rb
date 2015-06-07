require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  def setup
    @youtube_id = 'HJpaqOFjJME'
    @user = users(:bob)
    @video = videos(:one)
    @other_video = videos(:two)
    @category = categories(:roleplay)
  end

  test "should get :index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should redirect :new when not logged in" do
    get :new
    assert_not flash[:danger].empty?
    assert_redirected_to login_path
  end

  test "should get :new when logged in" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

  test "should redirect :create when not logged in" do
    assert_no_difference('Video.count') do
      post :create, video: { youtube_id: @youtube_id, category_ids: [@category.id] }
    end
    assert_not flash[:danger].empty?
    assert_redirected_to login_path
  end

  test "should :create video when logged in" do
    log_in_as(@user)
    assert_difference('Video.count') do
      post :create, video: { youtube_id: @youtube_id, category_ids: [@category.id] }
    end
    assert_redirected_to video_path(assigns(:video))
  end

  test "should :show video" do
    get :show, id: @video
    assert_response :success
  end

  test "should redirect :edit when not logged in" do
    get :edit, id: @video
    assert_not flash[:danger].empty?
    assert_redirected_to login_path
  end

  test "should redirect :edit when wrong user" do
    log_in_as(@user)
    get :edit, id: @other_video
    assert_redirected_to root_path
  end

  test "should get :edit when logged in" do
    log_in_as(@user)
    get :edit, id: @video
    assert_response :success
  end

  test "should redirect :update when not logged in" do
    patch :update, id: @video, video: { youtube_id: @video.youtube_id, category_ids: [@category.id] }
    assert_not flash[:danger].empty?
    assert_redirected_to login_path
  end

  test "should redirect :update when wrong user" do
    log_in_as(@user)
    patch :update, id: @other_video, video: { youtube_id: @other_video.youtube_id, category_ids: [@category.id] }
    assert_redirected_to root_path
  end 

  test "should :update video when logged in" do
    log_in_as(@user)
    patch :update, id: @video, video: { youtube_id: @video.youtube_id, category_ids: [@category.id] }
    assert_redirected_to video_path(assigns(:video))
  end

  test "should redirect :destroy when not logged in" do
    assert_no_difference('Video.count') do
      delete :destroy, id: @video
    end
    assert_not flash[:danger].empty?
    assert_redirected_to login_path
  end

  test "should redirect :destroy when wrong user" do
    log_in_as(@user)
    assert_no_difference('Video.count') do
      delete :destroy, id: @other_video
    end
    assert_redirected_to root_path
  end

  test "should :destroy video when logged in" do
    log_in_as(@user)
    assert_difference('Video.count', -1) do
      delete :destroy, id: @video
    end
    assert_equal @user.reload.trust_points, -10
    assert_redirected_to video_activations_path
  end
end
