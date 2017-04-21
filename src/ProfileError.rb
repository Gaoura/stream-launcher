require_relative "StreamLauncherError"

class ProfileError < StreamLauncherError
   class NoProfileFoundError < ProfileError; end
end
