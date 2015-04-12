require_relative 'ui/window'
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
      @dialog_controller = DialogController.new(Dialog.new)
    end

    def start
      @hero_controller.render
    end
  end
end