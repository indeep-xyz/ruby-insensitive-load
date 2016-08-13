require "insensitive_search/engine/linux"
require "insensitive_search/engine/windows"

module InsensitiveSearch
  class << self
    def run(*args, **options)
      Gem.win_platform? \
          ? Engine::Windows.new(**options).search(*args)
          : Engine::Linux.new(**options).search(*args)
    end

    def searchable?(*args)
      Engine::Base.allocate.searchable?(*args)
    end
  end
end