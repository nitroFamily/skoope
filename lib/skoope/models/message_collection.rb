require_relative 'collection'
require_relative 'message'

module Skoope
  module Models
    class MessageCollection < Collection
      attr_reader :user

      def initialize(client, user)
        super()
        @client = client
        @user = user

        @events.on(:new_message) do | data |
          receive_and_append(data)
        end

        @client.add_data_listener(self)
      end

      def send_and_append(text)
        message = Message.new("#{@user.name}", text)
        @client.send(message, "message")
        append(message)
      end

      def receive_and_append(data)
        message = data[:data]
        append(message)
      end

    end
  end
end