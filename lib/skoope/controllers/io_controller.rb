require_relative 'controller'

module Skoope
  module Controllers
    class IOController < Controller

      def initialize(view)
        super(view)

        @events.on(:key) do | key |
          case key
          when :space
            @io.start
          end
        end
      end

      def bind_to(instance)
        @io = instance
        @view.io = instance
        @io.client.add_data_listener(self)

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