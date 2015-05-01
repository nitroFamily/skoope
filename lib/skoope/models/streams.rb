require 'ffi-portaudio'


module Skoope
  module Models
    include FFI::PortAudio

    class IOStream < Stream
      attr_reader :events
      attr_accessor :buffer
      def initialize
        @events = Events.new
        @buffer = []
      end
    end

    class InputStream < IOStream
      def process(input, output, frameCount, timeInfo, statusFlags, userData)

        @buffer = input.read_array_of_int16(frameCount)
        @events.trigger(:new_input, @buffer)

        :paContinue
      end
    end

    class OutputStream < IOStream
      def process(input, output, frameCount, timeInfo, statusFlags, userData)
        output.write_array_of_int16(@buffer)

        :paContinue
      end
    end
  end
end