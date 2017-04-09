class StreamList

   # NOTE: Parameter checking will have to get done in the classes using this one

   attr_accessor :formatter

   def initialize
      @list_streams = []
   end

   # construct and add in an ordered way a stream to the list
   # unless the stream (based on his name attribute) is already included
   # or raise an exception
   def add(name, url_stream, url_chat)
      find(name)

      stream = Stream.new(name, url_stream, url_chat)
      @list_streams << stream
      @list_streams.sort! do |a,b|
         a.casecmp(b)
      end
   end

   alias << add

   def update(old_name, new_name, url_stream, url_chat)
      index = find(old_name)

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
      @list_streams.delete_at(index)
   end

   alias delete remove

   def get(name)
      index = find(stream.name)
      @list_streams[index]
   end

   alias [] get

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
      index = @list_streams.find_index do |item|
         item.name.casecmp?(name)
      end

      raise StreamListException if index.nil?
      index
   end

   alias index_of find
end
