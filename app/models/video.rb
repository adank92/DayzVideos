class Video < ActiveRecord::Base
  belongs_to :user
  has_many :video_categories
  has_many :categories, through: :video_categories

  validates :youtube_id, presence: true, uniqueness: :true
  validates :user, presence: true
  validates :categories, presence: true
  
  before_create :fetch_youtube_info

  default_scope -> { order(uploaded_at: :desc) }
  scope :category, -> (category) { joins(:categories).where(categories: { name: category }) if category.present? }
  scope :date, -> (type) { filter_date(type) if type.present? }
  scope :duration, -> (duration) { filter_duration(duration) if duration.present? }

  protected

    def fetch_youtube_info
      yt_video = Yt::Video.new(id: youtube_id)
      self.title = yt_video.title
      self.youtube_uploader = yt_video.channel_title
      self.duration = yt_video.duration
      self.img = yt_video.thumbnail_url(:medium)
      self.uploaded_at = yt_video.published_at
    rescue Yt::Errors::RequestError => e
      errors[:base] << "There was an issue trying to connect to youtube"
      false
    end

    def self.filter_date(type)
      minimum_date = case type
        when 'Today'
          1.day.ago
        when 'Week'
          1.week.ago
        when 'Month'
          1.month.ago
        when 'Year'
          1.year.ago
        end
      where('videos.uploaded_at > ?', minimum_date)
    end

    def self.filter_duration(duration)
      query = case duration
        when 'Short'
          ['videos.duration < ?', 240]
        when 'Medium'
          ['videos.duration > ? AND videos.duration < ?', 240, 600]
        when 'Long'
          ['videos.duration > ?', 600]
        end
      where(*query)
    end
end
