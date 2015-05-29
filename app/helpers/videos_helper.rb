module VideosHelper
  def youtube_url youtube_id
    "http://www.youtube.com/v/#{youtube_id}"
  end

  def clock_time time
    Time.at(time).utc.strftime("%M:%S")
  end
end
