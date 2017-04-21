module Livestreamer

   attr_reader :livestreamer

   def default_livestreamer
      raise LivestreamerError::NotInPathError unless ENV["PATH"].include?("livestreamer")
      @livestreamer = "livestreamer"
   end

   def update_livestreamer(path_to_livestreamer)
      check_livestreamer(path_to_livestreamer)
      @livestreamer = path_to_livestreamer
   end

   alias_method :livestreamer=, :update_livestreamer

   def check_livestreamer(path_to_livestreamer)
      if livestreamer == "livestreamer"
         raise LivestreamerError::NotInPathError unless ENV["PATH"].include?("livestreamer")
      else
         raise LivestreamerError::NonexistentError unless FileTest.exist?(path_to_livestreamer)
         raise LivestreamerError::NotExecutableError unless FileTest.executable?(path_to_livestreamer)
      end
   end
end
