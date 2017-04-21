require_relative "StreamLauncherError"

class BrowserError < StreamLauncherError
   class NonexistentError < BrowserError; end
   class NotExecutableError < BrowserError; end
end
