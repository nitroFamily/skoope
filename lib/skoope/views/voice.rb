require_relative '../ui/view'

module Skoope
  module Views
    class Voice < UI::View
      attr_accessor :io

      def draw
        line "#{@io.stream.buffer[0]}"
      end

    end
  end
end
