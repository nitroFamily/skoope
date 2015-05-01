require_relative '../ui/view'

module Skoope
  module Views
    class Voice < UI::View
      attr_accessor :io, :status

      def draw
        if @status == :ask_user
          line "u/n"
          @status = nil
        else
          with_color(:yellow) do
            if @io.duration
              duration = Time.now - @io.duration
              line "#{@io.status.to_s} #{duration}"
            else
              line "#{@io.status.to_s}"
            end
          end
        end
      end

      def ask_user
        line "press y/n"
      end

    end
  end
end
