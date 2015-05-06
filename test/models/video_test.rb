require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  def setup
    @video = videos(:one)
  end

  test "should be valid" do
    assert @video.valid?
  end

  test "youtube_id should be present" do
    @video.youtube_id = ""
    assert_not @video.valid?
  end

  test "youtube_id should be unique" do
    other_video = @video.dup
    assert_not other_video.valid?
  end

  test "user should be present" do
    @video.user_id = ""
    assert_not @video.valid?
  end

  test "categories should be present" do
    @video.category_ids = []
    assert_not @video.valid?
  end

  test "title should be present" do
    @video.title = ''
    assert_not @video.valid?
  end

  test "duration should be present" do
    @video.duration = ''
    assert_not @video.valid?
  end

  test "img should be present" do
    @video.img = ''
    assert_not @video.valid?
  end

  test "youtube_uploader should be present" do
    @video.youtube_uploader = ''
    assert_not @video.valid?
  end
end
