require "os"

require_relative "Error.rb"

module Browser

   def browser
      @@browser
   end

   def default_browser
      @@browser = OS.open_file_command
   end

   def update_browser(path_to_browser)
      unless path_to_browser == OS.open_file_command
         raise ::Error::NonexistentError unless FileTest.exist?(path_to_browser)
         raise ::Error::NotExecutableError unless FileTest.executable?(path_to_browser)
      end
      @@browser = path_to_browser
   end

   alias_method :browser=, :update_browser
end
