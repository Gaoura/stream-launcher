require "os"

require_relative "Error.rb"

module Livestreamer

   def livestreamer
      @@livestreamer
   end

   def default_livestreamer
      @@livestreamer = ENV["PATH"].include?("livestreamer") ? "livestreamer" : nil
   end

   def update_livestreamer(path_to_livestreamer)
      unless path_to_livestreamer == ENV["PATH"].include?("livestreamer") ? "livestreamer" : nil
         raise ::Error::NonexistentException unless FileTest.exist?(path_to_livestreamer)
         raise ::Error::NotExecutableError unless FileTest.executable?(path_to_livestreamer)
      end
      @@livestreamer = path_to_livestreamer
   end

   alias_method :livestreamer=, :update_livestreamer
end
