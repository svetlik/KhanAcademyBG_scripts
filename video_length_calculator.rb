require 'pry'
require 'video_info'
require 'net/http'
require "csv"

# Paste the urls to videos taken from the portal in a file called 'links.txt' in the same directory with this script file.

file_contents = []
File.open("links.txt", "r") do |f|
  f.each_line do |line|
    # This takes care of taking only the url part of the line and trimming the ''
    file_contents << line.split(',').first.tr('\'', '')
    puts line
  end
end

all_videos = file_contents
puts "All: #{all_videos}"

# Open a new csv file and start writing
CSV.open("video_durations_#{Time.now}.csv", 'wb') do |csv|
  csv << ['Title', 'Duration (s)', 'Duration (m)', 'URL', 'Video ID']
  all_videos.uniq.each do |video|
    begin
      res = Net::HTTP.get_response(URI(video))
      video_info = VideoInfo.new(res['location'].gsub('timedtext_video', 'watch'))
      csv << [video_info.title.to_s,
              video_info.duration.to_s,
              ((video_info.duration / 60.0 * 100).round / 100.0).to_s,
              video_info.url,
              video_info.video_id
            ]
      puts video
      puts "URL: #{video_info.url}"
      puts "Title: #{video_info.title}"
      puts "Length: #{video_info.duration}s (#{(video_info.duration/60.0*100).round/100.0}m)"
      puts '--------'
    rescue NoMethodError => e
      retry
    end
  end
end
