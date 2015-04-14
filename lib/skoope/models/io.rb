require 'ffi-portaudio'
require_relative '../events'

module Skoope
  module Models
    class InputStream < FFI::PortAudio::Stream
      attr_reader :events, :buffer
      def initialize
        @events = Events.new
        @buffer = []
      end

      def process(input, output, frameCount, timeInfo, statusFlags, userData)

        @buffer = input.read_array_of_int16(frameCount)
        @events.trigger(:new_input, @buffer)

        :paContinue
      end
    end

    class IO
      attr_accessor :stream
      include FFI::PortAudio

      BUFFER_SIZE = 300

      def initialize
        # @client = client
        # @user = user
        @active = false

        init_pa
        init_input
      end

      def init_pa
        API.Pa_Initialize
      end

      def init_input
        @input = API::PaStreamParameters.new
        @input[:device] = API.Pa_GetDefaultInputDevice
        @input[:channelCount] = 1
        @input[:sampleFormat] = API::Int16
        @input[:suggestedLatency] = 0
        @input[:hostApiSpecificStreamInfo] = nil

        @stream = InputStream.new
      end

      def start
        unless active?
          @stream.open(@input, nil, 44100, BUFFER_SIZE)
          @stream.start
          @active = true
        end
      end

      def close
        if active?
          @stream.close
          API.Pa_Terminate
        end
      end

      def active?
        @active == true
      end

    end
  end
end