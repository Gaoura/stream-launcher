require "yaml/store"

class StreamList

   attr_reader :list_streams

   def initialize
      @list_streams = []
   end

   # add in an ordered way a stream to the list unless the stream is already included
   # or raise an exception
   # (based on his name attribute)
   def add(stream)
      index = find(stream.name)
      raise StreamListException if index != nil

      @list_streams << stream
      @list_streams.sort! do |a,b|
         a.casecmp(b)
      end
   end

   alias << add

   def remove(stream)
      @list_streams.delete(stream)
   end

   alias delete remove

   def remove_by_name(name)
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
         item.name == name
      end
   end
end
