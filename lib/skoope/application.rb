require_relative 'ui/window'
require_relative 'ui/input'
require_relative 'ui/rect'

require_relative 'controllers/dialog_controller'
require_relative 'controllers/alive_controller'
require_relative 'controllers/io_controller'

require_relative 'models/message_collection'
require_relative 'models/user'
require_relative 'models/io'

require_relative 'views/dialog'
require_relative 'views/alive'
require_relative 'views/voice'
require_relative 'views/hero'


module Skoope
  class Application
    include Controllers
    include Models
    include Views

    def initialize(client)
      @window = UI::Window.new

      @hero_controller   = Controller.new(Hero.new(
                           UI::Rect.new(0, 0, Curses.cols, Curses.lines)))

      @dialog_controller = DialogController.new(Dialog.new(
                           UI::Rect.new(0, 2, Curses.cols, Curses.lines - 4)))

      @alive_controller  = AliveController.new(Alive.new(
                           UI::Rect.new(0, Curses.lines - 2, Curses.cols, 1)), client)

      @io_controller     = IOController.new(Voice.new(
                           UI::Rect.new(0, 0, Curses.cols, 2)), client)

      @dialog_controller.bind_to(MessageCollection.new(client, User.new(ARGV[0])))
      @io_controller.bind_to(IO.new(client))
    end

    def interaction
      loop do
        if @workaround_was_called_once_already
          handle UI::Input.get(-1)
        else
          @workaround_was_called_once_already = true
          handle UI::Input.get(0)
          @dialog_controller.render
          @io_controller.render
          @alive_controller.render
        end

        break if stop?
      end
    ensure
      @window.close
    end

    def handle(key)
      case key
      when :up, :down, :m
        @dialog_controller.events.trigger(:key, key)
      when :space, :y, :n
        @io_controller.events.trigger(:key, key)
      end
    end

    def start
      @hero_controller.render
      interaction
    end

    def stop
      @stop = true
    end

    def stop?
      @stop == true
    end
  end
end