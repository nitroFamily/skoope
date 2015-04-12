require_relative 'view'

module Skoope
  module UI
    class ScrollView < View

      def initialize(rect)
        super(rect)

        @current = 0
      end



    end
  end
end