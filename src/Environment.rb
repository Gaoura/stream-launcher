require_relative "Browser.rb"
require_relative "Livestreamer.rb"
require_relative "Language.rb"

class Environment
   include Browser
   include Livestreamer
   include Language

   def initialize
      @livestreamer = ""
      @browser = ""
   end

   def default
      default_browser
      default_livestreamer
      default_language
   end
end
