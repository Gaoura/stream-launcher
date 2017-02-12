class Stream

   attr_accessor :name, :url_stream, :url_chat

   def initialize(name, url_stream, url_chat = nil)
      @name = name
      @url_stream = url_stream
      @url_chat = url_chat
   end
end
