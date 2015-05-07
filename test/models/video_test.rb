require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  def setup
    @video = videos(:one)
  end

  test "should be valid" do
    assert @video.valid?
  end

  test ":youtube_id should be present" do
    @video.youtube_id = ""
    assert_not @video.valid?
  end

  test ":youtube_id should be unique" do
    other_video = @video.dup
    assert_not other_video.valid?
  end

  test ":user should be present" do
    @video.user_id = ""
    assert_not @video.valid?
  end

  test ":categories should be present" do
    @video.category_ids = []
    assert_not @video.valid?
  end

  test ":title should be present" do
    @video.title = ''
    assert_not @video.valid?
  end

  test ":duration should be present" do
    @video.duration = ''
    assert_not @video.valid?
  end

  test ":img should be present" do
    @video.img = ''
    assert_not @video.valid?
  end

  test ":youtube_uploader should be present" do
    @video.youtube_uploader = ''
    assert_not @video.valid?
  end

  test "should order by :uploaded_at" do
    assert_equal Video.all, [videos(:three), videos(:one), videos(:two)]
  end

  test "should filter by categories" do
    assert_equal Video.category(:gunfights), [videos(:three)]
    assert_equal Video.category(:roleplay), [videos(:one), videos(:two)]
  end

  test "should filter by date" do
    assert_equal Video.date('Today'), [videos(:three)]
    assert_equal Video.date('Week'), [videos(:three), videos(:one)]
    assert_equal Video.date('Month'), [videos(:three), videos(:one)]
    assert_equal Video.date('Year'), [videos(:three), videos(:one), videos(:two)]
  end

  test "should filter by duration" do
    assert_equal Video.duration('Short'), [videos(:one)]
    assert_equal Video.duration('Medium'), [videos(:three)]
    assert_equal Video.duration('Long'), [videos(:two)]
  end
end
