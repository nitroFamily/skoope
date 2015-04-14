require_relative 'controller'

module Skoope
  module Controllers
    class IOController < Controller

      def initialize(view)
        super(view)

        @io = Models::IO.new
        @view.io = @io

        @io.stream.events.on(:new_input) do | input |
          @view.render
        end

        @events.on(:key) do | key |
          case key
          when :space
            @io.start
          end
        end


      end


    end
  end
end