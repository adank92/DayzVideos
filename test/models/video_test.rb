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

  test "should filter by inactive" do
    assert_equal Video.inactive, [videos(:three), videos(:one)]
  end

  test "should filter by active" do
    assert_equal Video.active, [videos(:two)]
  end

  test "should fetch proper info from yt" do
    video = Video.new(youtube_id: 'HJpaqOFjJME')
    video.send(:fetch_youtube_info)
    assert_equal 'The Misfits - Descending Angel', video.title
    assert_equal 'Teemu Lönnblad', video.youtube_uploader
    assert_equal 231, video.duration
    assert_equal 'https://i.ytimg.com/vi/HJpaqOFjJME/mqdefault.jpg', video.img
    assert_equal '2009-11-02 17:44:34 UTC', video.uploaded_at.to_s
  end

  test "should activate video" do
    @video.activate
    assert @video.active?
    assert_equal @video.user.trust_points, 10
  end
end
