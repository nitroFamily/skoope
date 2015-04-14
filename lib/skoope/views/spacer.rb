require_relative '../ui/view'

module Skoope
  module Views
    class Spacer < UI::View

      def draw
        with_color(:black) do
          line "[input]"
        end
      end

    end
  end
end
