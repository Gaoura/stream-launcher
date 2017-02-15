require "minitest/autorun"

require_relative "../src/Stream"

describe Stream do
   let(:stream) { Stream.new("Zerator", "twitch.tv/zerator") }
   let(:stream2) { Stream.new("Zerator", "twitch.tv/zerator", "twitch.tv/zerator/chat") }

   describe "#stream_name" do
      it "should return stream name" do
         stream.name.must_equal("Zerator")
      end

      it "should return changed stream name" do
         stream.name = "Zerator2"
         stream.name.must_equal("Zerator2")
      end
   end

   describe "#stream_url" do
      it "should return stream url" do
         stream.url_stream.must_equal("twitch.tv/zerator")
      end

      it "should return changed stream url" do
         stream.url_stream = "twitch.tv/zerator2"
         stream.url_stream.must_equal("twitch.tv/zerator2")
      end
   end

   describe "#chat_url" do
      it "should return nil when there is no chat url available" do
         stream.url_chat.must_equal(nil)
      end

      it "should return changed chat url" do
         stream.url_chat = "twitch.tv/zerator/chat2"
         stream.url_chat.must_equal("twitch.tv/zerator/chat2")
      end

      it "should return chat url when all available" do
         stream2.url_chat.must_equal("twitch.tv/zerator/chat")
      end
   end
end
