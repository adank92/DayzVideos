json.array!(@videos) do |video|
  json.extract! video, :id, :title, :youtube_id, :uploader, :duration
  json.url video_url(video, format: :json)
end
