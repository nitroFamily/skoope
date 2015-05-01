require_relative 'controller'

module Skoope
  module Controllers
    class AliveController < Controller

      def initialize(view, client)
        super(view)

        @client = client
        @client.add_data_listener(self)
        @time = Time.now

        alive_checker

        @events.on(:new_management) do | data |
          case data[:data]
          when "alive?"
            @client.send("alive!", "management")
          when "alive!"
            @time = Time.now
            @view.status = "online"
            @view.render
          end
        end
      end

      def alive_checker
        @alive_checker_thread = Thread.new do
          loop do
            if Time.now - @time > 2
              @view.status = "offline"
              @view.render
            end
            @client.send("alive?", "management")
            sleep(1)
          end
        end
      end

      def stop
        @alive_checker_thread.kill
      end

    end
  end
end