module Skoope
  module Models
    class User

      def initialize(ip)
        @ip = ip
      end

      def name
        @ip
      end

    end
  end
end