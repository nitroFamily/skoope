require 'curses'

require_relative 'color'

module Skoope
  module UI
    class Window

      def initialize
        Curses.noecho
        Curses.stdscr.keypad(true)
        Curses.init_screen
        Color.init
      end

      def close
        Curses.close_screen
      end

    end
  end
end