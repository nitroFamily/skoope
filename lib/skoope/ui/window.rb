# require 'ncurses'
require 'curses'

module Skoope
  module UI
    class Window

      def initialize
        Curses.noecho # do not show typed keys
        Curses.stdscr.keypad(true) # enable arrow keys
        Curses.init_screen
        # Color.init
      end

      def close
        Curses.close_screen
      end

    end
  end
end