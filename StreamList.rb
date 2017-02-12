class StreamList

   # NOTE: Parameter checking will have to get done in the classes using this one

   attr_accessor :formatter

   def initialize(formatter)
      @list_streams = []
      @formatter = formatter
   end

   # construct and add in an ordered way a stream to the list
   # unless the stream (based on his name attribute) is already included
   # or raise an exception
   def add(name, url_stream, url_chat)
      index = find(name)
      raise StreamListException if index.nil?

      stream = Stream.new(name, url_stream, url_chat)
      @list_streams << stream
      @list_streams.sort! do |a,b|
         a.casecmp(b)
      end
   end

   alias << add

   def update(old_name, new_name, url_stream, url_chat)
      index = find(old_name)
      raise StreamListException if index.nil?

      stream = @list_streams[index]
      stream.name = new_name
      stream.url_name = url_stream
      stream.url_chat = url_chat
      if old_name.casecmp?(new_name)
         @list_streams.sort! do |a,b|
            a.casecmp(b)
         end
      end
   end

   def remove(name)
      index = find(stream.name)
      raise StreamListException if index.nil?

      @list_streams.delete_at(index)
   end

   alias delete_by_name remove_by_name

   def get(name)
      index = find(stream.name)
      raise StreamListException if index.nil?

      @list_streams[index]
   end

   def collect_names
      @list_streams.collect do |item|
         item.name
      end
   end

   def size
      @list_streams.size
   end

   def empty?
      @list_streams.empty?
   end

   def any?
      @list_streams.any?
   end

   def find(name)
      @list_streams.find_index do |item|
         item.name.casecmp?(name)
      end
   end

   def save(name)
      @formatter.save(self, name)
   end

   def load(name)
      @formatter.load(name)
   end
end
