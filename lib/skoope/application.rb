require_relative 'ui/window'
require_relative 'ui/input'
require_relative 'ui/rect'

require_relative 'controllers/dialog_controller'

# require_relative 'models/message_collection'

require_relative 'views/hero'
require_relative 'views/dialog'


module Skoope
  class Application
    include Controllers
    # include Models
    include Views

    def initialize(client)
      @window = UI::Window.new

      @hero_controller = Controller.new(Hero.new(
                         UI::Rect.new(0, 0, Curses.cols, Curses.lines)))
      @dialog_controller = DialogController.new(Dialog.new(
                           UI::Rect.new(0, 0, Curses.cols, Curses.lines - 2)))
    end

    def interaction
      loop do
        @dialog_controller.render
        handle UI::Input.get(0)
        break if stop?
      end
    ensure
      @window.close
    end

    def handle(key)
      case key
      when :up, :down
        @dialog_controller.events.trigger(:key, key)
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