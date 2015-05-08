require 'test_helper'

class VideoCreationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
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
  end
end
