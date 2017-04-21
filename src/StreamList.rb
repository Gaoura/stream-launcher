class StreamList

   # NOTE: Parameter checking will have to get done in the classes using this one

   def initialize
      @streams = []
   end

   # construct and add in an ordered way a stream to the list
   # unless the stream (based on his name attribute) is already included
   # or raise an exception
   def add(stream)
      puts find(stream.name)
      raise StreamListError::StreamAlreadyExistsError unless find(stream.name).nil?
      @streams << stream
      @streams.sort!
   end

   alias_method :<<, :add

   def update(old_name, new_name, url_stream, url_chat)
      index = find(old_name)
      raise StreamListError::StreamNotFoundError if index.nil?

      unless old_name.casecmp(new_name)
         raise StreamListError::StreamAlreadyExistsError unless find(new_name).nil?
      end

      stream = @streams[index]
      stream.name = new_name
      stream.url_stream = url_stream
      stream.url_chat = url_chat
      unless old_name.casecmp(new_name)
         @streams.sort!
      end
   end

   def remove(name)
      index = find(name)
      raise StreamListError::StreamNotFoundError if index.nil?
      @streams.delete_at(index)
   end

   alias_method :delete, :remove

   def get(name)
      index = find(name)
      raise StreamListError::StreamNotFoundError if index.nil?
      @streams[index]
   end

   alias_method :[], :get

   def collect_names
      @streams.collect do |item|
         item.name
      end
   end

   def size
      @streams.size
   end

   def empty?
      @streams.empty?
   end

   def any?
      @streams.any?
   end

   def find(name)
      @streams.find_index do |v|
         name == v.name
      end
   end

   alias_method :index_of, :find
end
