require_relative '../ui/scroll'

module Skoope
  module Views
    class Dialog < UI::Scroll
      def initialize(rect)
        super(rect)
        @keys = [:owner, :text] # specify model properties to display
      end

      def color_for(item)
        if @collection.user.name == item.owner
          :magenta
        else
          :cyan
        end
      end
    end
  end
end