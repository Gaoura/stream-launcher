class Stream

   attr_reader :name, :stream_url, :chat_url

   def initialize(name, stream_url, chat_url)
      self.name = name
      self.stream_url = stream_url
      self.chat_url = chat_url
   end

   def name=(name)
      raise StreamError::NameError if name.nil?
      name.strip!
      raise StreamError::NameError if name.empty?
      @name = name
   end

   def stream_url=(stream_url)
      raise StreamError::StreamURLError if stream_url.nil?
      stream_url.strip!
      raise StreamError::StreamURLError if stream_url.empty?
      @stream_url = stream_url
   end

   def chat_url=(chat_url)
      raise StreamError::ChatURLError if chat_url.nil?
      chat_url.strip!
      @chat_url = chat_url
   end

   def eql?(other)
      @name == other.name
   end

   def ==(other)
      @name == other.name
   end

   def <=>(other)
      @name.casecmp(other.name)
   end

   def hash
      @name.hash
   end
end
