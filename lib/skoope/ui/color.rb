require 'curses'

module Skoope
  module UI
    class Color
      PAIRS = {
        :white   => 0,
        :red     => 1,
        :yellow  => 2,
        :cyan    => 3,
        :magenta => 4,
        :green   => 5
      }

      DEFINITION = {
        PAIRS[:white]   => [ Curses::COLOR_WHITE,   Curses::COLOR_BLACK ],
        PAIRS[:red]     => [ Curses::COLOR_RED,     Curses::COLOR_BLACK ],
        PAIRS[:yellow]  => [ Curses::COLOR_YELLOW,  Curses::COLOR_BLACK ],
        PAIRS[:cyan]    => [ Curses::COLOR_CYAN,    Curses::COLOR_BLACK ],
        PAIRS[:magenta] => [ Curses::COLOR_MAGENTA, Curses::COLOR_BLACK ],
        PAIRS[:green]   => [ Curses::COLOR_GREEN,   Curses::COLOR_BLACK ],
      }

      COLORS = {
        :white   => Curses.color_pair(PAIRS[:white]),
        :black   => Curses.color_pair(PAIRS[:white])|Curses::A_REVERSE,
        :red     => Curses.color_pair(PAIRS[:red]),
        :yellow  => Curses.color_pair(PAIRS[:yellow]),
        :cyan    => Curses.color_pair(PAIRS[:cyan]),
        :magenta => Curses.color_pair(PAIRS[:magenta]),
        :green   => Curses.color_pair(PAIRS[:green]),
      }

      def self.init
        Curses.start_color

        DEFINITION.each do |definition, (color, background)|
          Curses.init_pair(definition, color, background)
        end
      end

      def self.get(name)
        COLORS[name]
      end

    end
  end
end
