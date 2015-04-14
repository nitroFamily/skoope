module Skoope
  module Models
    class Message
      attr_reader :owner, :text

      def initialize(owner, text)
        @owner = owner
        @text  = text
      end

    end
  end
end