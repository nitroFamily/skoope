require_relative '../ui/view'

module Skoope
  module Views
    class Hero < UI::View
      CONTENT = %q{
skoope
}

    protected

      def left
        (@rect.width - lines.map(&:length).max) / 2
      end

      def top
        (@rect.height - lines.size) / 2
      end

      def lines
        CONTENT.split("\n")
      end

      def draw
        0.upto(top) { line '' }
        lines.each do |row|
          with_color(:magenta) do
            line ' ' * left + row
          end
        end
      end

      def refresh
        super

        # show until any keypress
        @window.getch
      end

    end
  end
end
