require "os"

module Environment

   @@browser = OS.open_file_command
   @@livestreamer = ENV["PATH"].include?("livestreamer") ? "livestreamer" : nil

   def self.browser
      @@browser
   end

   def self.livestreamer
      @@livestreamer
   end

   def self.default_browser
      @@browser = OS.open_file_command
   end

   def self.default_livestreamer
      @@livestreamer = ENV["PATH"].include?("livestreamer") ? "livestreamer" : nil
   end

   def self.default
      default_browser
      default_livestreamer
      true
   end

   def self.update_browser(path_to_browser)
      if FileTest.exist?(path_to_browser)
         if FileTest.executable?(path_to_browser)
            @@browser = path_to_browser
         else
            raise NotExecutableException
         end
      else
         raise NonexistentException
      end
   end

   def self.update_livestreamer(path_to_livestreamer)
      if FileTest.exist?(path_to_livestreamer)
         if FileTest.executable?(path_to_livestreamer)
            @@livestreamer = path_to_livestreamer
         else
            raise NotExecutableException
         end
      else
         raise NonexistentException
      end
   end

   class << self
      alias_method :browser=, :update_browser
   end

end
