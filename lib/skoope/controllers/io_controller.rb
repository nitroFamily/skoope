require_relative 'controller'

module Skoope
  module Controllers
    class IOController < Controller

      def initialize(view, client)
        super(view)

        @client = client
        @client.add_data_listener(self)

        @events.on(:key) do | key |
          case key
          when :space
            @io.send_init
            @view.render
          when :y
            @io.send_ack
            @view.render
          when :n
            @io.send_fin
            @view.render
          end
        end

        @events.on(:new_management) do | data |
          case data[:data]
          when "init"
            if @io.status == :off
              @view.ask_user
              @view.render
            end
          when "ack"
            if @io.status == :wait
              @io.start
              @view.render
            end
          when "fin"
            if @io.status == :on
              @io.stop
              @view.render
            end
          end
        end
      end

      def bind_to(instance)
        @io = instance
        @view.io = instance

        @io.input_stream.events.on(:new_input) do | input |
          @view.render
          @io.send_buffer
        end

        @events.on(:new_voice) do | data |
          @view.render
          @io.receive_buffer(data)
        end
      end

    end
  end
end