require_relative "StreamLauncherError"

class LivestreamerError < StreamLauncherError
   class NonexistentError < LivestreamerError; end
   class NotExecutableError < LivestreamerError; end
   class NotInPathError < LivestreamerError; end
end
