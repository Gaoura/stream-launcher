class Stream

   attr_accessor :nom, :url_stream, :url_chat

   def initialize(nom, url_stream, url_chat)
      @nom = nom
      @url_stream = url_stream
      @url_chat = url_chat
   end
end
