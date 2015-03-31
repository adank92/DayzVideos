module VideosHelper
  def youtube_url youtube_id
    "http://www.youtube.com/v/#{youtube_id}"
  end
end
