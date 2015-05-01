require_relative '../ui/view'

module Skoope
  module Views
    class Alive < UI::View
      attr_accessor :status

      def draw
        case @status
        when "offline"
          with_color(:red) do
            line "[#{@status}]"
          end
        when "online"
          with_color(:green) do
            line "[#{@status}]"
          end
        end
      end

    end
  end
end
