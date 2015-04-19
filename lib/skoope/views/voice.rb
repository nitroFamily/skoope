require_relative '../ui/view'

module Skoope
  module Views
    class Voice < UI::View
      attr_accessor :io

      def draw
        # case @io.status
        # when :on
        #   line "#{@io.input_stream.buffer[0]} - #{@io.output_stream.buffer[0]}"
        # when :wait
        #   line "Wait ack ... "
        # when :off
        #   line "Press space to start"
        # end
        with_color(:yellow) do
          line @io.status.to_s
        end
      end

      def ask_user
        line "press y/n"
      end

    end
  end
end
