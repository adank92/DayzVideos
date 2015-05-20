require 'test_helper'

class VideosActivationTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:bob)
    @non_admin = users(:john)
  end

  test "view inactive videos and activate" do
    # access without login
    get video_activations_path
    assert_redirected_to login_path
    # access with non-admin user
    log_in_as(@non_admin)
    get video_activations_path
    assert_redirected_to root_path
    # acess with admin
    log_in_as(@admin)
    get video_activations_path
    assert_template 'video_activations/index'
    assert_select 'a', text: videos(:one).title
    assert_select 'a', text: videos(:three).title
    assert_select 'a', text: videos(:two).title, count: 0
    # activate video
    get edit_video_activation_path(videos(:two))
    video = videos(:two).reload
    assert_not flash['success'].empty?
    assert video.active?
    assert_equal video.user.trust_points, 70
    # delete video
    assert_difference('Video.count', -1) do      
      delete video_path(videos(:one))
    end
    assert_redirected_to video_activations_path
    assert_not flash[:success].empty?
  end
end
