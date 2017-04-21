require_relative "StreamLauncherError"

class StreamListError < StreamLauncherError
   class StreamNotFoundError < StreamListError; end
   class StreamAlreadyExistsError < StreamListError; end
end
