=begin USELESS FOR THE MOMENT, see is_stream_online?
require "open-uri"
require 'json'
=end

class Launcher

=begin REVIEW: Doesn't work, open give HTTPError 400 Bad Request
   def self.is_stream_online?(stream_url)
      # TODO: Twitch functionality only, might add Dailymotion, Youtube Live
      name = get_streamer_name(stream_url)
      raise StreamLauncherException if name.nil?

      response = open("https://api.twitch.tv/kraken/streams/" + name).read
      json_response = JSON.parse(response)
      json_response["stream"].nil? ? false : true
   end
=end

   def self.stream_availables_qualities(stream_url, path_to_livestreamer = nil)
      cmd_output
      if path_to_livestreamer.nil?
         cmd_output = system("livestreamer #{stream_url}")
      else
         cmd_output = system("#{path_to_livestreamer} #{stream_url}")
      end

      raise StreamLauncherException if cmd_output.include?("error:")

      # r1 cleans the output to get only the qualities separated by some characters...
      # r2 matches these characters to create and return an array containing the qualities
      r1 = Regexp.new(".+\sAvailable streams: ")
      r2 = Regexp.new("(\s\(\w+\)(\, )?)|(\, )")
      cmd_output.slice!(r1).split(r2)
   end

   def self.launch_stream(stream_url, quality, path_to_livestreamer = nil)
      pid
      if path_to_livestreamer.nil?
         pid = spawn("livestreamer #{stream_url} #{quality}")
      else
         pid = spawn("#{path_to_livestreamer} #{stream_url} #{quality}")
      end
      Process.detach pid
   end

   def self.launch_chat(chat_url, path_to_browser)
      pid = spawn("#{path_to_browser} #{chat_url}")
      Process.detach pid
   end

=begin USELESS FOR THE MOMENT, see is_stream_online?
   private

   def self.get_streamer_name(stream_url)
      # TODO: Twitch functionality only, might add Dailymotion, Youtube Live
      stream_url.match(/.*\twitch.tv\/\1(\/)|(.*)/)[1]
   end
=end
end
