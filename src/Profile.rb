class Profile

   attr_accessor :name, :stream_list

   def initialize(name, stream_list = StreamList.new)
      @name = name
      @stream_list = stream_list
   end

=begin
   def default_profile

      profiles = Dir['../profiles/*.yml'].each do |v|
         File.basename(v, ".*")
      end
      raise ::Error::NoProfileFoundError if profiles.empty?
      @profile = profiles[0]

      # @profile = ""
   end
=end

   def self.profile_choice
      profiles = Dir['../profiles/*.yml'].each do |v|
         File.basename(v, ".*")
      end
      raise ProfileError::NoProfileFoundError if profiles.empty?
      profiles
   end

   def self.save(profile)
      YAMLFormatter.save(profile.stream_list, File.expand_path("../profiles/%s.yml" % profile.name))
   end

   def self.load(profile_name)
      Profile.new(profile_name, YAMLFormatter.load(File.expand_path("../profiles/%s.yml" % profile_name)))
   end

   def self.delete(profile_name)
      File.delete(File.expand_path("../profiles/%s.yml" % profile_name))
   end
end
