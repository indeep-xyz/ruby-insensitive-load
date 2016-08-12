require "insensitive_load/search/linux"
require "insensitive_load/search/windows"

module InsensitiveLoad
  module Search
    DEFAULT_DELIMITER = Gem.win_platform? ? '\\' : '/'

    class << self
      def run(*args)
        Base.run(*args)
      end
    end
  end
end