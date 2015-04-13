require_relative 'view'

module Skoope
  module UI
    class Scroll < View
      attr_reader :collection
      attr_accessor :keys

      SEPARATOR = ' >> '

      def initialize(rect)
        super(rect)
        @offset = 0
      end


      def bind_to(collection)
        @collection = collection
        @collection.events.on(:append) do
          @offset = length > @rect.height ? length - @rect.height : 0
          render
        end
        # @collection.events.on(:replace) { clear; render }
      end

      def length
        @collection.length
      end

      def up
        if @offset > 0
          @offset -= 1
          render
        end
      end

      def down
        if @offset < (length - rect.height)
          @offset += 1
          render
        end
      end

      protected
        def rows
          @collection[@offset, length].each do | item, index |
            content = []
            keys.each do |key|
              content << item.send(key).to_s
            end

            with_color(color_for(item)) do
              line content.join(SEPARATOR)
            end
          end
        end

        def draw
          rows
        end

        def color_for(item)
        end

    end
  end
end