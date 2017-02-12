class StreamList

   def initialize
      @list_streams = []
   end

   # construct and add in an ordered way a stream to the list
   # unless the stream (based on his name attribute) is already included
   # or raise an exception
   # NOTE: Parameter checking will have to be done in the classes using this one
   def add(name, url_stream, url_chat)
      index = find(name)
      raise StreamListException if index != nil

      stream = Stream.new(name, url_stream, url_chat)
      @list_streams << stream
      @list_streams.sort! do |a,b|
         a.casecmp(b)
      end
   end

   alias << add

   def change(old_name, new_name, url_stream, url_chat)
      index = find(old_name)
      raise StreamListException if index != nil

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
      index = self.find(stream.name)
      raise StreamListException if index != nil

      @list_streams.delete_at(index)
   end

   alias delete_by_name remove_by_name

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
end
