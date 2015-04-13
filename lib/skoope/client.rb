require 'socket'
require 'thread'

module Skoope
  class Client

    DEFAULT_PORT = 3000

    def initialize(src_ip, dst_ip)
      @src_ip = src_ip
      @dst_ip = dst_ip
      @listeners = []
      @listening = false
      @port = DEFAULT_PORT
      @socket = UDPSocket.new
    end

    def add_data_listener(listener)
      listen unless listening?
      @listeners << listener
    end

    def send(message, type)
      app_packet = {type: "#{type}", data: message}
      @socket.send(Marshal.dump(app_packet), 0, @dst_ip, @port)
    end

    def listen
    @socket.bind(@src_ip, @port)

      @listening_thread = Thread.new do
        loop do
          raw_data = @socket.recvfrom(1500)[0]

          data = Marshal.load(raw_data)

          @listeners.each do | listener |
            if data[:type] == "message"
              listener.events.trigger(:new_message, data)
            end
          end
        end
      end

      @listening = true
    end

    def listening?
      @listening == true
    end

    def close
      @socket.close
    end

  end
end