require_relative 'controller'

module Skoope
  module Controllers
    class DialogController < Controller

      def initialize(view)
        super(view)

        # events.on(:key) do |key|
        #   case key
        #   when :up
        #     @view.up
        #   when :down
        #     @view.down
        #   end
        # end

      end

    end
  end
end