require_relative '../events'
require_relative 'streams'

module Skoope
  module Models
    class IO
      attr_accessor :input_stream, :output_stream, :client, :status, :duration
      include FFI::PortAudio

      BUFFER_SIZE = 300

      def initialize(client)
        @events = Events.new
        @client = client
        @status = :off

        @duration = nil

        init_pa
        init_input
        init_output
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
          @input_stream.open(@input, nil, 5_000, BUFFER_SIZE)
          @output_stream.open(nil, @output, 5_000, BUFFER_SIZE)

          @input_stream.start
          @output_stream.start
          @status = :on

          @duration = Time.now
        end
      end

      def stop
        if active?
          @input_stream.close
          @output_stream.close
        end
        @status = :off

        @duration = nil
      end

      def send_buffer
        @client.send(@input_stream.buffer, "voice")
      end

      def receive_buffer(data)
        @output_stream.buffer = data[:data]
      end

      def send_init
        if @status == :off
          # @client.send("init", "management")
          3.times { @client.send("init", "management") }
          @status = :wait
        end
      end

      def send_ack
        if @status == :off
          # @client.send("ack", "management")
          3.times { @client.send("ack", "management") }
          start
        end
      end

      def send_fin
        if @status == :wait || @status == :on
          3.times { @client.send("fin", "management") }
          stop
          # @client.send("fin", "management")
        end
      end

      def close
        if active?
          stop
          API.Pa_Terminate
        end
      end

      def active?
        @status == :on
      end

    end
  end
end