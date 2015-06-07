require 'test_helper'

class VideoCreationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
    @trusted_user = users(:john)
    @video = videos(:one)
    @categories = Category.all
  end

  test "video creation" do
    youtube_id = 'HJpaqOFjJME'
    youtube_id_2 = 'lgSLz5FeXUg'
    # assert layout elements
    log_in_as(@user)
    get new_video_path
    assert_template 'videos/new'
    assert_select 'input#video_youtube_id'
    assert_select 'select[multiple=multiple]#video_category_ids'
    @categories.each do |c|
      assert_select 'option', text: c.name
    end
    # create a video with invalid info
    assert_no_difference 'Video.count' do
      post videos_path, video: { youtube_id: '', category_ids: [] }
    end
    assert_template 'videos/new'
    assert_select 'div#error_explanation'
    assert_select 'div#error_explanation li'
    # create a video with valid info, send to queue
    assert_difference 'Video.count', 1  do
      post videos_path, video: { youtube_id: youtube_id, category_ids: [@categories.first.id]}
    end
    video = assigns(:video)
    assert_redirected_to video
    # shouldn't be shown in index
    get root_path
    assert_select 'a[data-youtube-url=?]', "http://www.youtube.com/v/#{youtube_id}", 0
    # create a video with valid info, don't send to queue
    log_in_as(@trusted_user)
    assert_difference 'Video.count', 1  do
      post videos_path, video: { youtube_id: youtube_id_2, category_ids: [@categories.first.id]}
    end
  end

  test "video update" do
    log_in_as(@user)
    youtube_id = 'asdfasdf'
    category_ids = [@categories.first.id]
    get edit_video_path(@video)
    assert_template 'videos/edit'
    # the youtube_id field should be disabled
    assert_select 'input[disabled=disabled]#video_youtube_id'
    patch video_path(@video), video: { youtube_id: youtube_id, category_ids: category_ids }
    @video.reload
    # the update method should not update youtube_id
    assert_not_equal @video.youtube_id, youtube_id
    # categories should update
    assert_equal @video.category_ids, category_ids
  end
end
