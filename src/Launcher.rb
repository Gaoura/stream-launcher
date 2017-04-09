=begin USELESS FOR THE MOMENT, see is_stream_online?
require "open-uri"
require 'json'
=end

class Launcher

   class << self
      private :new
   end

=begin REVIEW: Doesn't work, open give HTTPError 400 Bad Request

# Solution is there : https://github.com/justintv/Twitch-API/blob/master/authentication.md#implicit-grant
# Twitch API needs an authentication now
# So we can ask for user to authorize this application on his Twitch account
# Or use this functionality included in livestreamer
# (CLI : "livestreamer --twitch-oauth-authenticate" ;
# then config file : "twitch-oauth-token=xxxx or CLi : "livestreamer --twitch-oauth-token xxxx stream")
# and just check the livestreamer output to know if stream is online or offline
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
      if path_to_livestreamer.nil?
         cmd_output = `livestreamer #{stream_url}`
      else
         cmd_output = `#{path_to_livestreamer} #{stream_url}`
      end

      # TODO: manage error case where livestreamer won't even work

      raise StreamLauncherException if cmd_output.include?("error:")

      # r1 cleans the output to get only the qualities separated by some characters...
      # r2 matches these characters to create and return an array containing the qualities
      r1 = Regexp.new(".+\sAvailable streams: ")
      r2 = Regexp.new("(\s\(\w+\)(\, )?)|(\, )")
      cmd_output.slice!(r1).split(r2)
   end

   def self.launch_stream(stream_url, quality, path_to_livestreamer = nil)
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

   def self.record(stream_url, quality, path_to_livestreamer = nil, path_to_recording_directory = ".")
      if path_to_livestreamer.nil?
         pid = spawn("livestreamer #{stream_url} #{quality} -o #{path_to_recording_directory}")
      else
         pid = spawn("#{path_to_livestreamer} #{stream_url} #{quality} -o #{path_to_recording_directory}")
      end
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
