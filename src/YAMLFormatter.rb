require 'yaml'

module YAMLFormatter

   def self.save(object, name)
      raise YAMLFormatterError::FileAlreadyExistError if File.exists?(name)
      overwrite(object, name)
   end

   def self.overwrite(object, name)
      File.open(name, "w") do |f|
         f.write(object.to_yaml)
      end
   end

   def self.load(name)
      raise YAMLFormatterError::NonexistentError unless File.exists?(name)
      YAML.load(File.open(name))
   end
end
