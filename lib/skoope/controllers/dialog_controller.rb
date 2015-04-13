require_relative 'controller'

module Skoope
  module Controllers
    class DialogController < Controller

      def initialize(view)
        super(view)

        @events.on(:key) do |key|
          case key
          when :up
            @view.up
          when :down
            @view.down
          when :m
            text = UI::Input.getstr('New Message: ')
            @messages.send_and_append(text) if text.length > 0
          end
        end
      end

      def bind_to(messages)
        @messages = messages
        @view.bind_to(messages)
      end

    end
  end
end