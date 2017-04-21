require_relative "Environment"

class Config

   attr_accessor :windows_cmd_width, :filename_max_length, :filename_forbidden_char,
                  :chcp, :last_used_profile, :environment, :default_quality

   def initialize(cmd_width = 80, max_length = 254,
               forbidden_char = ["\\", "/", "*", "?", "\"", "<", ">", "|"],
               chcp = 65001, last_used_profile = "", environment = Environment.new,
               default_quality = "best")
      @windows_cmd_width = cmd_width
      @filename_max_length = max_length
      @filename_forbidden_char = forbidden_char
      @chcp = chcp
      @last_used_profile = last_used_profile
      @environment = environment
      @default_quality = default_quality
   end
end
