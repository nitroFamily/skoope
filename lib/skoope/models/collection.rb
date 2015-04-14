require_relative '../events'

module Skoope
  module Models
    class Collection
      include Enumerable
      attr_reader :events, :items

      def initialize
        @events = Events.new
        @items = []
      end

      def [](*args)
        @items[*args]
      end

      def each(&block)
        @items.each(&block)
      end

      def append(item)
        @items << item
        @events.trigger(:append)
      end

      def length
        @items.length
      end

    end
  end
end