require 'yaml'

class YAMLFormatter

   class << self
      private :new
   end

   def self.save(object, name)
      File.open(name, "w") do |f|
         f.write(object.to_yaml)
      end
   end

   def self.load(name)
      if File.exists?(name)
         YAML.load(File.open(name))
      end
   end
end
