require 'test_helper'

class VideoCreationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
    @video = videos(:one)
    @categories = Category.all
  end

  test "video creation" do
    log_in_as(@user)
    get new_video_path
    assert_template 'videos/new'
    assert_select 'input#video_youtube_id'
    assert_select 'select[multiple=multiple]#video_category_ids'
    @categories.each do |c|
      assert_select 'option', text: c.name
    end
    # invalid information
    assert_no_difference 'Video.count' do
      post videos_path, video: { youtube_id: '', category_ids: [] }
    end
    assert_template 'videos/new'
    assert_select 'div#error_explanation'
    assert_select 'div#error_explanation li'
    assert_difference 'Video.count', 1  do
      post videos_path, video: { youtube_id: 'HJpaqOFjJME', category_ids: [@categories.first.id]}
    end
    video = assigns(:video)
    assert_redirected_to video
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
