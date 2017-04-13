module Environment
   module_function

   include Browser
   include Livestreamer

   def default
      default_browser
      default_livestreamer
      true
   end
end
