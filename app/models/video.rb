class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories

  validates :youtube_id, presence: true

  before_save :fetch_youtube_info

  protected

  def fetch_youtube_info
    yt_client = YouTubeIt::Client.new(dev_key: Rails.application.secrets.youtube_key)
    yt_video = yt_client.video_by(youtube_id)
    self.title = yt_video.title
    self.uploader = yt_video.author.name
    self.duration = yt_video.duration
    self.img = yt_video.thumbnails[1].url
  end
end
