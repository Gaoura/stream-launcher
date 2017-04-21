require "os"

module Browser

   attr_reader :browser

   def default_browser
      @browser = OS.open_file_command
   end

   def update_browser(path_to_browser)
      @browser = path_to_browser
   end

   alias_method :browser=, :update_browser

   def check_browser(path_to_browser)
      unless path_to_browser == OS.open_file_command
         raise BrowserError::NonexistentError unless FileTest.exist?(path_to_browser)
         raise BrowserError::NotExecutableError unless FileTest.executable?(path_to_browser)
      end
   end
end
