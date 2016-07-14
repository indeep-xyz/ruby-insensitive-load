require "insensitive_load/collector/linux"
require "insensitive_load/collector/windows"

module InsensitiveLoad
  module Collector
    DEFAULT_DELIMITER = Gem.win_platform? ? '\\' : '/'

    class << self
      def new(*args)
        Gem.win_platform? \
            ? Windows.new(*args)
            : Linux.new(*args)
      end
    end
  end
end