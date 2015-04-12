require_relative 'view'

module Skoope
  module UI
    class Scroll < View

      def initialize(rect)
        super(rect)

        @collection = []

        100.times do | i |
          @collection << "hello #{i}"
        end

        @offset = length > @rect.height ? length - @rect.height : 0
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
          @collection[@offset, length].each do | item |
            line item
          end
        end

        def draw
          rows
        end

    end
  end
end