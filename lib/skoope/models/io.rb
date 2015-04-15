require_relative '../events'
require_relative 'streams'

module Skoope
  module Models
    class IO
      attr_accessor :input_stream, :output_stream, :client
      include FFI::PortAudio

      BUFFER_SIZE = 300

      def initialize(client)
        @events = Events.new
        @client = client
        # @user = user
        @active = false

        init_pa
        init_input
        init_output

        # @events.on(:new_voice) do | data |
        #   # @output_stream.buffer = data[:data]
        # end

        # @client.add_data_listener(self)
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

        @input_stream = InputStream.new
      end

      def init_output
        @output = API::PaStreamParameters.new
        @output[:device] = API.Pa_GetDefaultOutputDevice
        @output[:channelCount] = 1
        @output[:sampleFormat] = API::Int16
        @output[:suggestedLatency] = 0
        @output[:hostApiSpecificStreamInfo] = nil

        @output_stream = OutputStream.new
      end

      def start
        unless active?
          @input_stream.open(@input, nil, 10_000, BUFFER_SIZE)
          @output_stream.open(nil, @output, 10_000, BUFFER_SIZE)

          @input_stream.start
          @output_stream.start
          @active = true
        end
      end

      def send_buffer
        @client.send(@input_stream.buffer, "voice")
      end

      def receive_buffer(data)
        @output_stream.buffer = data[:data]
      end

      def close
        if active?
          @input_stream.close
          @output_stream.close
          API.Pa_Terminate
        end
      end

      def active?
        @active == true
      end

    end
  end
end