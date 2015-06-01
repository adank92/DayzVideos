module VideosHelper
  def youtube_url youtube_id
    "https://www.youtube.com/embed/#{youtube_id}"
  end

  def clock_time time
    Time.at(time).utc.strftime("%M:%S")
  end
end
