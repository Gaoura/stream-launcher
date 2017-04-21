require_relative "StreamLauncherError"

class StreamError < StreamLauncherError
   class NameError < StreamError; end
   class StreamURLError < StreamError; end
   class ChatURLError < StreamError; end
end
