require 'yaml'

class YAMLFormatter

   def save(stream_list, name)
      File.open(name, "w") do |f|
         f.write(stream_list.to_yaml)
      end
   end

   def load(name)
      if File.exists?(name)
         YAML.load(File.open(name))
      end
   end
end
